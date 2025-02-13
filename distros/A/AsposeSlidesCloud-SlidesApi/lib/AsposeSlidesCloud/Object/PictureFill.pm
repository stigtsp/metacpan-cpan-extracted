=begin comment

Copyright (c) 2019 Aspose Pty Ltd

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=end comment

=cut

package AsposeSlidesCloud::Object::PictureFill;

require 5.6.0;
use strict;
use warnings;
use utf8;
use JSON qw(decode_json);
use Data::Dumper;
use Module::Runtime qw(use_module);
use Log::Any qw($log);
use Date::Parse;
use DateTime;

use AsposeSlidesCloud::Object::FillFormat;
use AsposeSlidesCloud::Object::ImageTransformEffect;
use AsposeSlidesCloud::Object::ResourceUri;

use base ("Class::Accessor", "Class::Data::Inheritable");


#
#Picture fill.
#
# NOTE: This class is auto generated by the swagger code generator program. Do not edit the class manually.
# REF: https://github.com/swagger-api/swagger-codegen
#

=begin comment

Copyright (c) 2019 Aspose Pty Ltd

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=end comment

=cut
#
# NOTE: This class is auto generated by the swagger code generator program. 
# Do not edit the class manually.
# Ref: https://github.com/swagger-api/swagger-codegen
#
__PACKAGE__->mk_classdata('attribute_map' => {});
__PACKAGE__->mk_classdata('swagger_types' => {});
__PACKAGE__->mk_classdata('method_documentation' => {}); 
__PACKAGE__->mk_classdata('class_documentation' => {});

# new object
sub new { 
    my ($class, %args) = @_; 

	my $self = bless {}, $class;
	
	foreach my $attribute (keys %{$class->attribute_map}) {
		my $args_key = $class->attribute_map->{$attribute};
		$self->$attribute( $args{ $args_key } );
	}
	$self->{ type } = 'Picture';
	return $self;
}  

# return perl hash
sub to_hash {
    return decode_json(JSON->new->convert_blessed->encode( shift ));
}

# used by JSON for serialization
sub TO_JSON { 
    my $self = shift;
    my $_data = {};
    foreach my $_key (keys %{$self->attribute_map}) {
        if (defined $self->{$_key}) {
            $_data->{$self->attribute_map->{$_key}} = $self->{$_key};
        }
    }
    return $_data;
}

# from Perl hashref
sub from_hash {
    my ($self, $hash) = @_;

    # loop through attributes and use swagger_types to deserialize the data
    my $current_types = {};
    while ( my ($_key, $_type) = each %{$self->swagger_types} ) {
        $current_types->{$_key} = $_type;
    }
    while ( my ($_key, $_type) = each %{$current_types} ) {
    	my $_json_attribute = $self->attribute_map->{$_key}; 
        if ($_type =~ /^array\[/i) { # array
            my $_subclass = substr($_type, 6, -1);
            my @_array = ();
            foreach my $_element (@{$hash->{$_json_attribute}}) {
                if (defined $_element) {
                    push @_array, $self->_deserialize($_subclass, $_element);
                } else {
                    push @_array, undef;
                }
            }
            foreach my $_element (@{$hash->{lcfirst($_json_attribute)}}) {
                if (defined $_element) {
                    push @_array, $self->_deserialize(lcfirst($_subclass), $_element);
                } else {
                    push @_array, undef;
                }
            }
            $self->{$_key} = \@_array;
        } elsif (exists $hash->{$_json_attribute}) { #hash(model), primitive, datetime
            $self->{$_key} = $self->_deserialize($_type, $hash->{$_json_attribute});
        } elsif (exists $hash->{lcfirst($_json_attribute)}) { #hash(model), primitive, datetime
            $self->{$_key} = $self->_deserialize($_type, $hash->{lcfirst($_json_attribute)});
        }
    }
  
    return $self;
}

# deserialize non-array data
sub _deserialize {
    my ($self, $type, $data) = @_;
        
    if ($type eq 'DateTime') {
        return DateTime->from_epoch(epoch => str2time($data));
    } elsif ( grep( /^$type$/, ('int', 'double', 'string', 'boolean'))) {
        return $data;
    } else { # hash(model)
        my $class = AsposeSlidesCloud::ClassRegistry->get_class_name(ucfirst($type), $data);
        my $_instance = use_module("AsposeSlidesCloud::Object::$class")->new();
        return $_instance->from_hash($data);
    }
}



__PACKAGE__->class_documentation({description => 'Picture fill.',
                                  class => 'PictureFill',
                                  required => [], # TODO
}                                 );

__PACKAGE__->method_documentation({
    'type' => {
    	datatype => 'string',
    	base_name => 'Type',
    	description => 'Fill type.',
    	format => '',
    	read_only => '',
    		},
    'crop_bottom' => {
    	datatype => 'double',
    	base_name => 'CropBottom',
    	description => 'Percentage of image height that is cropped from the bottom.',
    	format => '',
    	read_only => '',
    		},
    'crop_left' => {
    	datatype => 'double',
    	base_name => 'CropLeft',
    	description => 'Percentage of image height that is cropped from the left.',
    	format => '',
    	read_only => '',
    		},
    'crop_right' => {
    	datatype => 'double',
    	base_name => 'CropRight',
    	description => 'Percentage of image height that is cropped from the right.',
    	format => '',
    	read_only => '',
    		},
    'crop_top' => {
    	datatype => 'double',
    	base_name => 'CropTop',
    	description => 'Percentage of image height that is cropped from the top.',
    	format => '',
    	read_only => '',
    		},
    'dpi' => {
    	datatype => 'int',
    	base_name => 'Dpi',
    	description => 'Picture resolution.',
    	format => '',
    	read_only => '',
    		},
    'image' => {
    	datatype => 'ResourceUri',
    	base_name => 'Image',
    	description => 'Internal image link.',
    	format => '',
    	read_only => '',
    		},
    'base64_data' => {
    	datatype => 'string',
    	base_name => 'Base64Data',
    	description => 'Base 64 image data.',
    	format => '',
    	read_only => '',
    		},
    'svg_data' => {
    	datatype => 'string',
    	base_name => 'SvgData',
    	description => 'SVG image data.',
    	format => '',
    	read_only => '',
    		},
    'picture_fill_mode' => {
    	datatype => 'string',
    	base_name => 'PictureFillMode',
    	description => 'Fill mode.',
    	format => '',
    	read_only => '',
    		},
    'image_transform_list' => {
    	datatype => 'ARRAY[ImageTransformEffect]',
    	base_name => 'ImageTransformList',
    	description => 'Image transform effects.',
    	format => '',
    	read_only => '',
    		},
});

__PACKAGE__->swagger_types( {
    'type' => 'string',
    'crop_bottom' => 'double',
    'crop_left' => 'double',
    'crop_right' => 'double',
    'crop_top' => 'double',
    'dpi' => 'int',
    'image' => 'ResourceUri',
    'base64_data' => 'string',
    'svg_data' => 'string',
    'picture_fill_mode' => 'string',
    'image_transform_list' => 'ARRAY[ImageTransformEffect]'
} );

__PACKAGE__->attribute_map( {
    'type' => 'Type',
    'crop_bottom' => 'CropBottom',
    'crop_left' => 'CropLeft',
    'crop_right' => 'CropRight',
    'crop_top' => 'CropTop',
    'dpi' => 'Dpi',
    'image' => 'Image',
    'base64_data' => 'Base64Data',
    'svg_data' => 'SvgData',
    'picture_fill_mode' => 'PictureFillMode',
    'image_transform_list' => 'ImageTransformList'
} );

__PACKAGE__->mk_accessors(keys %{__PACKAGE__->attribute_map});


1;
