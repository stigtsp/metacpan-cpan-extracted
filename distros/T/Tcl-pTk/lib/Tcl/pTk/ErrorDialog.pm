package Tcl::pTk::ErrorDialog;

our ($VERSION) = ('1.09');

use warnings;
use strict;

use Tcl::pTk ();
require Tcl::pTk::Dialog;
use base qw(Tcl::pTk::Toplevel);
use vars ( qw/ $ED_OBJECT /);

# ErrorDialog - a translation of bgerror() from Tcl/Tk to Perl/Tk.
#
# Currently TkPerl background errors are sent to stdout/stderr; use this
# module if you want them in a window.  You can also "roll your own" by
# supplying the routine Tcl::pTk::Error.

Construct Tcl::pTk::Widget 'ErrorDialog';

my %options = ( -buttons => ['OK', 'Skip Messages', 'Stack trace'],
                -bitmap  => 'error'
              );


sub import
{
 my $class = shift;
 while (@_)
  {
   my $key = shift;
   my $val = shift;
   $options{$key} = $val;
  }
}

sub Populate {

    # ErrorDialog constructor.  Uses `new' method from base class
    # to create object container then creates the dialog toplevel and the
    # traceback toplevel.

    my($cw, $args) = @_;

    my $dr = $cw->MainWindow->Dialog(
        -title          => 'Error in '.$cw->MainWindow->name,
        -text           => 'on-the-fly-text',
        -bitmap         => $options{'-bitmap'},
	-buttons        => $options{'-buttons'},
    );
    $cw->minsize(1, 1);
    $cw->title('Stack Trace for Error');
    $cw->iconname('Stack Trace');
    my $t_ok = $cw->Button(
        -text    => 'OK',
        -command => [
            sub {
		shift->withdraw;
	    }, $cw,
        ]
    );
    my $t_text = $cw->Text(
        -relief  => 'sunken',
        -bd      => 2,
        -setgrid => 'true',
        -width   => 60,
        -height  => 20,
    );
    my $t_scroll = $cw->Scrollbar(
        -relief => 'sunken',
        -command => ['yview', $t_text],
    );
    $t_text->configure(-yscrollcommand => ['set', $t_scroll]);
    $t_ok->pack(-side => 'bottom', -padx => '3m', -pady => '2m');
    $t_scroll->pack(-side => 'right', -fill => 'y');
    $t_text->pack(-side => 'left', -expand => 'yes', -fill => 'both');
    $cw->withdraw;

    $cw->Advertise(error_dialog => $dr); # advertise dialog widget
    $cw->Advertise(text => $t_text);     # advertise text widget
    $cw->ConfigSpecs(-cleanupcode => [PASSIVE => undef, undef, undef],
                     -appendtraceback => [ PASSIVE => undef, undef, 1 ]);
    $ED_OBJECT = $cw;
    $cw->protocol('WM_DELETE_WINDOW' => sub {$cw->withdraw});
    return $cw;

} # end Populate

sub Tcl::pTk::Error {

    # Post a dialog box with the error message and give the user a chance
    # to see a more detailed stack trace.

    my($w, $error, @msgs) = @_;

    my $grab = $w->grabCurrent();
    $grab->Unbusy if (defined $grab);

    $w->ErrorDialog if not defined $ED_OBJECT;

    my($d, $t) = ($ED_OBJECT->Subwidget('error_dialog'), $ED_OBJECT->Subwidget('text'));
#   chop $error;
    $d->configure(-text => "Error:  $error");
    $d->bell;
    #$ED_OBJECT->deiconify;
    my $ans = $d->Show;

    $t->delete('0.0', 'end') if not $ED_OBJECT->{'-appendtraceback'};
    $t->insert('end', "\n");
    $t->mark('set', 'ltb', 'end');
    $t->insert('end', "--- Begin Traceback ---\n$error\n");
    my $msg;
    for $msg (@msgs) {
	$t->insert('end', "$msg\n");
    }
    $t->yview('ltb');

    $ED_OBJECT->deiconify if ($ans =~ /trace/i);

    my $c = $ED_OBJECT->{Configure}{'-cleanupcode'};
    &$c if defined $c;		# execute any cleanup code if it was defined
    $w->break if ($ans =~ /skip/i);

} # end Tcl::pTk::Error

1;
