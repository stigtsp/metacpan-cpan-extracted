# -*- perl -*-
BEGIN { $|=1; $^W=1; }
use strict;
use Test;
##
## Almost all widget classes:  load module, create, pack, and
## destory an instance.
##
## Menu stuff not tested up to now
##

use vars '@class';

BEGIN
  {
    @class = (
	# Tk core widgets
	qw(
		TableMatrix
		TableMatrix::Spreadsheet
		TableMatrix::SpreadsheetHideRows
		
	)
   );

   plan test => (13*@class+3);

  };

use constant HAVE_DISPLAY => $^O =~ /Win/ || defined $ENV{DISPLAY};
use constant SKIP => HAVE_DISPLAY ? 0 : 'Skip if no display';

eval { require Tk; };
ok($@, "", "loading Tk module");

my $mw;
eval {$mw = Tk::MainWindow->new();};
skip(SKIP, $@, "", "can't create MainWindow");
skip(SKIP, Tk::Exists($mw), 1, "MainWindow creation failed");
eval { $mw->geometry('+10+10'); };  # This works for mwm and interactivePlacement

my $w;
foreach my $class (@class)
  {
    print "Testing $class\n";
    undef($w);

    eval "require Tk::$class;";
    ok($@, "", "Error loading Tk::$class");
    ok("Tk::$class"->isa('Tk::Widget'),1,"Tk::$class is not a widget");
    
    my $classCall = $class; # name of class, as it is called
    $classCall =~ s/.+?\:\://; 
    eval { $w = $mw->$classCall(); };
    skip(SKIP, $@, "", "can't create $class widget");
    skip(SKIP || $@, Tk::Exists($w), 1, "$class instance does not exist");


    if (Tk::Exists($w))
      {
        if ($w->isa('Tk::Wm'))
          {
	    # KDE-beta4 wm with policies:
	    #     'interactive placement'
	    #		 okay with geometry and positionfrom
	    #     'manual placement'
	    #		geometry and positionfrom do not help
	    eval { $w->positionfrom('user'); };
            #eval { $w->geometry('+10+10'); };
	    ok ($@, "", 'Problem set postitionform to user');

            eval { $w->Popup; };
	    ok ($@, "", "Can't Popup a $class widget")
          }
        else
          {
	    ok(1); # dummy for above positionfrom test
            eval { $w->pack; };
	    ok ($@, "", "Can't pack a $class widget")
          }
        eval { $mw->update; };
        ok ($@, "", "Error during 'update' for $class widget");

        my @dummy;
        eval { @dummy = $w->configure; };
        ok ($@, "", "Error: configure list for $class");
        my $dummy;
        eval { $dummy = $w->configure; };
        ok ($@, "", "Error: configure scalar for $class");
        ok (scalar(@dummy),scalar(@$dummy), "Error: scalar config != list config");

        eval { $mw->update; };
        ok ($@, "", "Error: 'update' after configure for $class widget");

        eval { $w->destroy; };
        ok($@, "", "can't destroy $class widget");
        ok(!Tk::Exists($w), 1, "$class: widget not really destroyed");

        # XXX: destroy-destroy test disabled because nobody vote for this feature
	# Nick Ing-Simmmons wrote:
	# The only way to make test pass, is when Tk800 would fail, to specifcally look
	# and see if method is 'destroy', and ignore it. Can be done but is it worth it?
	# Note I cannot call tk's internal destroy as I have no way of relating
	# (now destroy has happened) the object back to interp/MainWindow that it used
	# to be associated with, and hence cannot create the args I need to pass
	# to the core.

        # since Tk8.0 a destroy on an already destroyed widget should
        # not complain
        #eval { $w->destroy; };
        #ok($@, "", "Ooops, destroying a destroyed widget should not complain");

      }
    else
      {
        # Widget $class couldn't be created:
	#	Popup/pack, update, destroy skipped
	for (1..9) { skip (1,1,1, "skipped because widget could not be created"); }
      }
  }

1;
__END__
