=encoding utf8

=head1 Name

SPVM::Document::ExchangeAPI - SPVM Exchange API

=head1 Description

SPVM Exchange API is APIs to convert Perl data structures to/from SPVM data structures, and call SPVM Method from Perl.

=head1 Loading SPVM Module

If you load SVPM module from Perl, use the following syntax.

  use SPVM 'Foo';

Suppose the following C<SPVM/Foo.spvm> is placed on a module search path.

  # SPVM/Foo.spvm
  class Foo {
    static method sum : int ($x1 : int, $x2 : int) {
      return $x1 + $x2;
    }
  }

If you load SPVM C<Foo::Bar> module, do the following.

  use SPVM 'Foo::Bar';

Suppose the following C<SPVM/Foo/Bar.spvm> is placed on a module search path.

  # SPVM/Foo/Bar.spvm
  class Foo::Bar {
    static method sum : int ($x1 : int, $x2 : int) {
      return $x1 + $x2;
    }
  }

C<use SPVM MODULE_NAME> compile the SPVM module and the dependent modules.

Note that at this point a SPVM runtime has not yet been created.

A default SPVM runtime is created the first time you call a method of SPVM module or call a function or method of the Exchange API.

=head1 Calling SPVM Method

The method of SPVM module can be called from Perl directory.

=head2 Calling SPVM Class Method

Let's call SPVM class method from Perl.

  use SPVM 'Foo';

  my $total = SPVM::Foo->sum(1, 2);

The definition of C<Foo> module is the following.

  # SPVM/Foo.spvm
  class Foo {
    static method sum : int ($x1 : int, $x2 : int) {
      return $x1 + $x2;
    }
  }

If the number of arguments does not match the number of arguments of the SPVM method, an exception occurs.

The Perl values of the arguments are converted to the SPVM values by the rule of argument convertion.

If the type is non-conforming, an exception occurs.

The SPVM return value is converted to a Perl return value by the rule of return value convertion.

The SPVM exception is converted to a Perl exception.

=head2 Calling SPVM Instance Method

Let's call SPVM instance method from Perl.

  use SPVM 'Foo';

  my $foo = SPVM::Foo->new;

  my $total = $foo->sum(1, 2);

The definition of C<Foo> module is the following.

  # SPVM/Foo.spvm
  class Foo {
    static method new : Foo () {
      return new Foo;
    }

    method sum : int ($x1 : int, $x2 : int) (
      return $x1 + $x2;
    }
  }

=head1 Argument Conversion

Perl arguments are converted to SPVM arguments in the following rules.

=head2 Argument general exception

If the count of given arguments is less than the count of the arguments of the method, an exception occurs.

If the count of given arguments is more than the count of the arguments of the method, an exception occurs.

=head2 Perl Scalar to SPVM byte

If the SPVM argument type is C<byte>, Perl scalar is converted to SPVM C<byte> value using L<SvIV of perlapi|https://perldoc.perl.org/perlapi#SvIV>

The conversion logic is

  (int8_t)SvIV(perl_scalar)

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : byte) { ... }
  }
  
  # Perl
  SPVM::My->foo(12);

=head2 Perl Scalar to SPVM short

If the SPVM argument type is C<short>, Perl scalar is converted to SPVM C<short> value using L<SvIV of perlapi|https://perldoc.perl.org/perlapi#SvIV>

The conversion logic is
  
  (int16_t)SvIV(perl_scalar)

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : short) { ... }
  }
  
  # Perl
  SPVM::My->foo(12);

=head2 Perl Scalar to SPVM int

If the SPVM argument type is C<int>, Perl scalar is converted to SPVM C<int> value using L<SvIV of perlapi|https://perldoc.perl.org/perlapi#SvIV>

The conversion logic is

  (int32_t)SvIV(perl_scalar)

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : int) { ... }
  }
  
  # Perl
  SPVM::My->foo(12);

=head2 Perl Scalar to SPVM long

If the SPVM argument type is C<long>, Perl scalar is converted to SPVM C<long> value using L<SvIV of perlapi|https://perldoc.perl.org/perlapi#SvIV>

The conversion logic is

  (int64_t)SvIV(perl_scalar)

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : long) { ... }
  }
  
  # Perl
  SPVM::My->foo(12);

=head2 Perl Scalar to SPVM float

If the SPVM argument type is C<float>, Perl scalar is converted to SPVM C<float> value using L<SvNV of perlapi|https://perldoc.perl.org/perlapi#SvIV>

The conversion logic is

  (float)SvNV(perl_scalar)

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : float) { ... }
  }
  
  # Perl
  SPVM::My->foo(1.2);

=head2 Perl Scalar to SPVM double

If the SPVM argument type is C<double>, Perl scalar is converted to SPVM C<double> value using L<SvNV of perlapi|https://perldoc.perl.org/perlapi#SvIV>

The conversion logic is

  (double)SvNV(perl_scalar)

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : double) { ... }
  }
  
  # Perl
  SPVM::My->foo(1.2);

=head2 Perl Scalar to SPVM String

If the SPVM argument type is C<string>, the given Perl scalar is converted by the following rules.

If any of the following rules does not match, an exception occurs.

=head3 Perl Non-Reference Scalar to SPVM String

If the SPVM argument type is C<string>, the given Perl non-ref scalar is converted to L<SPVM::BlessedObject::String> object.

The given non-ref scalar value is assumed to a Perl decoded string, and is converted to UTF-8 bytes.

If the given non-ref scalar value is Perl C<undef>, it is converted to Perl C<undef>.

And the following L</"Perl SPVM::BlessedObject::String to SPVM String"> conversion is contined.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : string) { ... }
  }
  
  # Perl
  SPVM::My->foo("あいう");

=head3 Perl SPVM::BlessedObject::String to SPVM String

No conversion occurs.

Perl can have SPVM string itself as L<SPVM::BlessedObject::String> object. This object is created by such as L</"new_string">, L</"new_string_from_bin">, or got as a return value of SPVM method.

If the given value is Perl C<undef>, it is converted to SPVM C<undef>

  # SPVM method definition
  class My {
    static method foo : void ($value : string) { ... }
  }
  
  # Perl
  my $string = SPVM::new_string("あいう");
  SPVM::My->foo($string);

=head2 Perl SPVM::BlessedObject::Class to SPVM Class

No conversion occurs.

Perl can have SPVM class object itself as a object which inherits L<SPVM::BlessedObject::Class>. This object is created by a contructor such as SPVM::Int->new, SPVM::MyClass->new.

If the given value is Perl C<undef>, it is converted to SPVM C<undef>.

If class name is different, an exception occurs.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : SPVM::Int) { ... }
  }
  
  # Perl
  my $value = SPVM::Int->new(5);
  SPVM::My->foo($value);

=head2 Perl SPVM::BlessedObject to SPVM Any Object

No conversion occurs.

Perl can have SPVM object itself as a L<SPVM::BlessedObject> object. This object is created by a contructor or functions of exchange API such as SPVM::Int->new, SPVM::MyClass->new, SPVM::new_int_array.

If the given value is Perl C<undef>, it is converted to SPVM C<undef>.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : object) { ... }
  }
  
  # Perl
  my $value = SPVM::Int->new(5);
  SPVM::My->foo($value);

=head2 Perl Array Reference to SPVM Array

A Perl array reference is converted to a SPVM array by the following rules.

=head3 Perl Array Reference to SPVM byte Array

If the SPVM argument type is C<byte[]>, the Perl array reference is converted to SPVM array which type is C<byte[]>. Each element is converted to C<byte> value by L<the rule of Perl scalar to SPVM byte|"Perl Scalar to SPVM byte">. Perl C<undef> is coverted to SPVM C<undef>.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($values : byte[]) { ... }
  }
  
  # Perl
  SPVM::My->foo([1, 2, 3]);

=head3 Perl Array Reference to SPVM short Array

If the SPVM argument type is C<short[]>, the Perl array reference is converted to SPVM array which type is C<short[]>. Each element is converted to C<short> value by L<the rule of Perl Scalar to SPVM short|"Perl Scalar to SPVM short">. Perl C<undef> is coverted to SPVM C<undef>.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($values : short[]) { ... }
  }
  
  # Perl
  SPVM::My->foo([1, 2, 3]);

=head3 Perl Array Reference to SPVM int Array

If the SPVM argument type is C<int[]>, the Perl array reference is converted to SPVM array which type is C<int[]>. Each element is converted to C<int> value by L<the rule of Perl scalar to SPVM int|"Perl Scalar to SPVM int">. Perl C<undef> is coverted to SPVM C<undef>.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($values : int[]) { ... }
  }
  
  # Perl
  SPVM::My->foo([1, 2, 3]);

=head3 Perl Array Reference to SPVM long Array

If the SPVM argument type is C<long[]>, the Perl array reference is converted to SPVM array which type is C<long[]>. Each element is converted to C<long> value by L<the rule of Perl scalar to SPVM long|"Perl Scalar to SPVM long">. Perl C<undef> is coverted to SPVM C<undef>.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($values : long[]) { ... }
  }
  
  # Perl
  SPVM::My->foo([1, 2, 3]);

=head3 Perl Array Reference to SPVM float Array

If the SPVM argument type is C<float[]>, the Perl array reference is converted to SPVM array which type is C<float[]>. Each element is converted to C<float> value by L<the rule of Perl scalar to SPVM float|"Perl Scalar to SPVM float">. Perl C<undef> is coverted to SPVM C<undef>.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($values : float[]) { ... }
  }
  
  # Perl
  SPVM::My->foo([1.2, 2.3, 3.4]);

=head3 Perl Array Reference to SPVM double Array

If the SPVM argument type is C<double[]>, the Perl array reference is converted to SPVM array which type is C<double[]>. Each element is converted to C<double> value by L<the rule of Perl scalar to SPVM double|"Perl Scalar to SPVM double">. Perl C<undef> is coverted to SPVM C<undef>.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($values : double[]) { ... }
  }
  
  # Perl
  SPVM::My->foo([1.2, 2.3, 3.4]);

=head3 Perl Array Reference to SPVM String Array

If the SPVM argument type is C<string[]>, the Perl array reference is converted to SPVM array which type is C<string[]>. Each element is converted to C<string> value by L<the rule of Perl scalar to SPVM string|"Perl Scalar to SPVM string">. Perl C<undef> is coverted to SPVM C<undef>.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($values : string[]) { ... }
  }
  
  # Perl
  SPVM::My->foo(["あい", "うえ", "お"]);

=head3 Perl Array Reference to SPVM Multi-Numeric Array

If the SPVM argument type is an array of multi-numeric type, the given Perl array reference is converted to SPVM multi-numeric array which element type is multi-numeric type. Each element which is a hash reference is converted to multi-numeric type by L<the rule of Perl hash reference to SPVM multi-numeric type|"Perl hash reference to SPVM multi-numeric type">. Perl C<undef> is coverted to SPVM C<undef>.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($values : Complex_2d[]) { ... }
  }
  
  # Perl
  SPVM::My->foo([{re => 1.2, im => 2.3}, {re => 3.4, im => 4.5}]);

=head2 Perl SPVM::BlessedObject::Array to SPVM Array

No conversion occurs.

Perl can have SPVM array itself as L<SPVM::BlessedObject::Array> object. This object is created by such as L</"new_byte_array">, L</"new_short_array">, L</"new_int_array">, L</"new_long_array">, L</"new_float_array">, L</"new_double_array">, or got as a return value of SPVM method.

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($values : int[]) { ... }
  }
  
  # Perl
  my $array = SPVM::new_int_array([1, 2, 3]);
  SPVM::My->foo($array);

=head2 Perl Hash Reference to SPVM Multi-Numeric

If the SPVM argument type is a multi-numeric type, the given argument is converted by the following rules.

=head3 Perl Hash Reference to SPVM multi-numeric byte

If the argument type is a multi-numeric byte type, the given argument is hash reference is converted to the value of SPVM multi-numeric byte type. If the given argument is different from a hash reference, an exception occurs. Each field is converted to C<byte> value by L<the rule of Perl scalar to SPVM byte|"Perl Scalar to SPVM byte">.

If a filed is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2b {
    has x : byte;
    has y : byte;
  }
  class My {
    static method foo : void ($value : MyPoint_2b);
  }

  # Perl
  SPVM::My->foo({x => 1, y => 2});

=head3 Perl Hash Reference to SPVM Multi-Numeric short

If the argument type is a multi-numeric short type, the given argument is hash reference is converted to the value of SPVM multi-numeric short type. If the given argument is different from a hash reference, an exception occurs. Each field is converted to C<short> value by L<the rule of Perl scalar to SPVM short|"Perl Scalar to SPVM short">.

If a filed is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2s {
    has x : short;
    has y : short;
  }
  class My {
    static method foo : void ($value : MyPoint_2s);
  }

  # Perl
  SPVM::My->foo({x => 1, y => 2});

=head3 Perl Hash Reference to SPVM Multi-Numeric int

If the argument type is a multi-numeric int type, the given argument is hash reference is converted to the value of SPVM multi-numeric int type. If the given argument is different from a hash reference, an exception occurs. Each field is converted to C<int> value by L<the rule of Perl scalar to SPVM int|"Perl Scalar to SPVM int">.

If a filed is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2i {
    has x : int;
    has y : int;
  }
  class My {
    static method foo : void ($value : MyPoint_2i);
  }

  # Perl
  SPVM::My->foo({x => 1, y => 2});

=head3 Perl Hash Reference to SPVM Multi-Numeric long

If the argument type is a multi-numeric long type, the given argument is hash reference is converted to the value of SPVM multi-numeric long type. If the given argument is different from a hash reference, an exception occurs. Each field is converted to C<long> value by L<the rule of Perl scalar to SPVM long|"Perl Scalar to SPVM long">.

If a filed is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2l {
    has x : long;
    has y : long;
  }
  class My {
    static method foo : void ($value : MyPoint_2l);
  }

  # Perl
  SPVM::My->foo({x => 1, y => 2});

=head3 Perl Hash Reference to SPVM Multi-Numeric float

If the argument type is a multi-numeric float type, the given argument is hash reference is converted to the value of SPVM multi-numeric float type. If the given argument is different from a hash reference, an exception occurs. Each field is converted to C<float> value by L<the rule of Perl scalar to SPVM float|"Perl Scalar to SPVM float">.

If a filed is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2f {
    has x : float;
    has y : float;
  }
  class My {
    static method foo : void ($value : MyPoint_2f);
  }

  # Perl
  SPVM::My->foo({x => 1.2, y => 2.3});

=head3 Perl Hash Reference to SPVM Multi-Numeric double

If the argument type is a multi-numeric double type, the given argument is hash reference is converted to the value of SPVM multi-numeric double type. If the given argument is different from a hash reference, an exception occurs. Each field is converted to C<double> value by L<the rule of Perl scalar to SPVM double|"Perl Scalar to SPVM double">.

If a filed is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2d {
    has x : double;
    has y : double;
  }
  class My {
    static method foo : void ($value : MyPoint_2d);
  }

  # Perl
  SPVM::My->foo({x => 1.2, y => 2.3});

=head2 Perl Reference to SPVM Numeric Reference

If the SPVM argument type is numeric reference type, the given Perl reference is converted to SPVM numeric reference type in the following rules.

=head3 Perl Reference to SPVM byte Reference

If the SPVM argument type is byte reference type, the given Perl reference is converted to SPVM byte reference type.

The given value must be a scalar reference which referenced value is non-ref scalar. Otherwise an exception will occur.

The given value is converted to C<byte> value by L<the rule of Perl scalar to SPVM byte|"Perl Scalar to SPVM byte"> and return value is converted to Perl scalar by L<the rule of SPVM byte to Perl Scalar|"SPVM byte to Perl scalar">

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : byte*);
  }

  # Perl
  my $value = 23;
  SPVM::My->foo(\$value);

=head3 Perl Reference to SPVM short Reference

If the SPVM argument type is short reference type, the given Perl reference is converted to SPVM short reference type.

The given value must be a scalar reference which referenced value is non-ref scalar. Otherwise an exception will occur.

The given value is converted to C<short> value by L<the rule of Perl scalar to SPVM short|"Perl Scalar to SPVM short"> and return value is converted to Perl scalar by L<the rule of SPVM short to Perl Scalar|"SPVM short to Perl scalar">

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : short*);
  }

  # Perl
  my $value = 23;
  SPVM::My->foo(\$value);

=head3 Perl Reference to SPVM int Reference

If the SPVM argument type is int reference type, the given Perl reference is converted to SPVM int reference type.

The given value must be a scalar reference which referenced value is non-ref scalar. Otherwise an exception will occur.

The given value is converted to C<int> value by L<the rule of Perl scalar to SPVM int|"Perl Scalar to SPVM int"> and return value is converted to Perl scalar by L<the rule of SPVM int to Perl Scalar|"SPVM int to Perl scalar">

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : int*);
  }

  # Perl
  my $value = 23;
  SPVM::My->foo(\$value);

=head3 Perl Reference to SPVM long Reference

If the SPVM argument type is long reference type, the given Perl reference is converted to SPVM long reference type.

The given value must be a scalar reference which referenced value is non-ref scalar. Otherwise an exception will occur.

The given value is converted to C<long> value by L<the rule of Perl scalar to SPVM long|"Perl Scalar to SPVM long"> and return value is converted to Perl scalar by L<the rule of SPVM long to Perl Scalar|"SPVM long to Perl scalar">

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : long*);
  }

  # Perl
  my $value = 23;
  SPVM::My->foo(\$value);

=head3 Perl Reference to SPVM float Reference

If the SPVM argument type is float reference type, the given Perl reference is converted to SPVM float reference type.

The given value must be a scalar reference which referenced value is non-ref scalar. Otherwise an exception will occur.

The given value is converted to C<float> value by L<the rule of Perl scalar to SPVM float|"Perl Scalar to SPVM float"> and return value is converted to Perl scalar by L<the rule of SPVM float to Perl Scalar|"SPVM float to Perl scalar">

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : float*);
  }

  # Perl
  my $value = 23.5;
  SPVM::My->foo(\$value);

=head3 Perl Reference to SPVM double Reference

If the SPVM argument type is double reference type, the given Perl reference is converted to SPVM double reference type.

The given value must be a scalar reference which referenced value is non-ref scalar. Otherwise an exception will occur.

The given value is converted to C<double> value by L<the rule of Perl scalar to SPVM double|"Perl Scalar to SPVM double"> and return value is converted to Perl scalar by L<the rule of SPVM double to Perl Scalar|"SPVM double to Perl scalar">

B<Example:>

  # SPVM method definition
  class My {
    static method foo : void ($value : double*);
  }

  # Perl
  my $value = 23.5;
  SPVM::My->foo(\$value);

=head2 Perl Reference to SPVM Multi-Numeric Reference

If the SPVM argument type is multi-numeric reference type, the given Perl reference is converted by the following rules.

=head3 Perl Reference to SPVM multi-numeric byte reference

If the SPVM argument type is multi-numeric byte reference type, the given Perl reference is converted to SPVM multi-numeric byte reference type.

The given reference must be a scalar reference of hash reference. Otherwise an exception will occur.

The each field of the hash of the given argument is converted to C<byte> value by L<the rule of Perl scalar to SPVM byte|"Perl Scalar to SPVM byte"> and the each filed of the return value is converted to Perl scalar by L<the rule of SPVM byte to Perl Scalar|"SPVM byte to Perl scalar">

If a field is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2b {
    has x : byte;
    has y : byte;
  }
  class My {
    static method foo : void ($value : MyPoint_2b);
  }

  # Perl
  my $value = {x => 1, y => 2};
  SPVM::My->foo(\$value);

=head3 Perl Reference to SPVM Multi-Numeric short Reference

If the SPVM argument type is multi-numeric short reference type, the given Perl reference is converted to SPVM multi-numeric short reference type.

The given reference must be a scalar reference of hash reference. Otherwise an exception will occur.

The each field of the hash of the given argument is converted to C<short> value by L<the rule of Perl scalar to SPVM short|"Perl Scalar to SPVM short"> and the each filed of the return value is converted to Perl scalar by L<the rule of SPVM short to Perl Scalar|"SPVM short to Perl scalar">

If a field is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2s {
    has x : short;
    has y : short;
  }
  class My {
    static method foo : void ($value : MyPoint_2s);
  }

  # Perl
  my $value = {x => 1, y => 2};
  SPVM::My->foo(\$value);

=head3 Perl Reference to SPVM Multi-Numeric int Reference

If the SPVM argument type is multi-numeric int reference type, the given Perl reference is converted to SPVM multi-numeric int reference type.

The given reference must be a scalar reference of hash reference. Otherwise an exception will occur.

The each field of the hash of the given argument is converted to C<int> value by L<the rule of Perl scalar to SPVM int|"Perl Scalar to SPVM int"> and the each filed of the return value is converted to Perl scalar by L<the rule of SPVM int to Perl Scalar|"SPVM int to Perl scalar">

If a field is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2i {
    has x : int;
    has y : int;
  }
  class My {
    static method foo : void ($value : MyPoint_2i);
  }

  # Perl
  my $value = {x => 1, y => 2};
  SPVM::My->foo(\$value);

=head3 Perl Reference to SPVM Multi-Numeric long Reference

If the SPVM argument type is multi-numeric long reference type, the given Perl reference is converted to SPVM multi-numeric long reference type.

The given reference must be a scalar reference of hash reference. Otherwise an exception will occur.

The each field of the hash of the given argument is converted to C<long> value by L<the rule of Perl scalar to SPVM long|"Perl Scalar to SPVM long"> and the each filed of the return value is converted to Perl scalar by L<the rule of SPVM long to Perl Scalar|"SPVM long to Perl scalar">

If a field is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2l {
    has x : long;
    has y : long;
  }
  class My {
    static method foo : void ($value : MyPoint_2l);
  }

  # Perl
  my $value = {x => 1, y => 2};
  SPVM::My->foo(\$value);

=head3 Perl Reference to SPVM Multi-Numeric float Reference

If the SPVM argument type is multi-numeric float reference type, the given Perl reference is converted to SPVM multi-numeric float reference type.

The given reference must be a scalar reference of hash reference. Otherwise an exception will occur.

The each field of the hash of the given argument is converted to C<float> value by L<the rule of Perl scalar to SPVM float|"Perl Scalar to SPVM float"> and the each filed of the return value is converted to Perl scalar by L<the rule of SPVM float to Perl Scalar|"SPVM float to Perl scalar">

If a field is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2f {
    has x : float;
    has y : float;
  }
  class My {
    static method foo : void ($value : MyPoint_2f);
  }

  # Perl
  my $value = {x => 1,2, y => 2.3};
  SPVM::My->foo(\$value);

=head3 Perl Reference to SPVM Multi-Numeric double Reference

If the SPVM argument type is multi-numeric double reference type, the given Perl reference is converted to SPVM multi-numeric double reference type.

The given reference must be a scalar reference of hash reference. Otherwise an exception will occur.

The each field of the hash of the given argument is converted to C<double> value by L<the rule of Perl scalar to SPVM double|"Perl Scalar to SPVM double"> and the each filed of the return value is converted to Perl scalar by L<the rule of SPVM double to Perl Scalar|"SPVM double to Perl scalar">

If a field is missing, an exception occurs.

B<Example:>

  # SPVM multi-numeric type and method definition
  class MyPoint_2d {
    has x : double;
    has y : double;
  }
  class My {
    static method foo : void ($value : MyPoint_2d);
  }

  # Perl
  my $value = {x => 1.2, y => 2.3};
  SPVM::My->foo(\$value);

=head1 Return Value Conversion

a SPVM return value is converted to a Perl value by the following rules.

=head2 SPVM void to Perl undef

SPVM void return value is converted to Perl C<undef>. This is only for specification and has no meaning.

=head2 SPVM byte to Perl Scalar

SPVM byte value(same type as int8_t of C language) is converted to Perl scalar by L<newSViv function of perlapi|https://perldoc.perl.org/perlapi#newSViv>.

  int8_t spvm_byte_value = VALUE;
  SV* perl_scalar = newSViv(spvm_byte_value);

=head2 SPVM short to Perl Scalar

SPVM short value(same type as int16_t of C language) is converted to Perl scalar by L<newSViv function of perlapi|https://perldoc.perl.org/perlapi#newSViv>.

  int16_t spvm_short_value = VALUE;
  SV* perl_scalar = newSViv(spvm_short_value);

=head2 SPVM int to Perl Scalar

SPVM int value(same type as int32_t of C language) is converted to Perl scalar by L<newSViv function of perlapi|https://perldoc.perl.org/perlapi#newSViv>.

  int32_t spvm_int_value = VALUE;
  SV* perl_scalar = newSViv(spvm_int_value);

=head2 SPVM long to Perl Scalar

SPVM long value(same type as int64_t of C language) is converted to Perl scalar by L<newSViv function of perlapi|https://perldoc.perl.org/perlapi#newSViv>.

  int64_t spvm_long_value = VALUE;
  SV* perl_scalar = newSViv(spvm_long_value);

=head2 SPVM float to Perl Scalar

SPVM float value(same type as float of C language) is converted to Perl scalar by L<newSVnv function of perlapi|https://perldoc.perl.org/perlapi#newSVnv>.

  float spvm_float_value = VALUE;
  SV* perl_scalar = newSVnv(spvm_float_value);

=head2 SPVM double to Perl Scalar

SPVM double value(same type as double of C language) is converted to Perl scalar by L<newSVnv function of perlapi|https://perldoc.perl.org/perlapi#newSVnv>.

  double spvm_double_value = VALUE;
  SV* perl_scalar = newSVnv(spvm_double_value);

=head2 SPVM String to Perl String

SPVM String is converted to a Perl decoded string. If SPVM C<undef> is returned, it is converted to Perl C<undef>.

=head2 SPVM Object to Perl Object

a SPVM object(not contain array) is converted to a Perl object which class name is same as SPVM class name and inherits L<SPVM::BlessedObject::Class>.

=head2 SPVM Multi-Numeric to Perl Hash Reference

SPVM multi-numeric value is converted to Perl hash reference which keys is the field names of multi-numeric type. The rules of number convertions of the field of multi-numeric value is same as above the numeric convertions(byte, short, int, long, float, double).

=head2 SPVM Array to Perl SPVM::BlessedObject::Array

a SPVM array is converted to a Perl L<SPVM::BlessedObject::Array> object. If SPVM return value is C<undef>, it is converted to Perl C<undef>.

=head2 SPVM Object to Perl Object

a SPVM object is converted to a Perl object which class name is same as SPVM class name and inherits L<SPVM::BlessedObject::Class>.

=head1 Functions

Funtions which create SPVM datas and convert SVPM datas to/from Perl data.

=head2 new_byte_array

  my $spvm_nums = SPVM::new_byte_array([1, 2, 3]);

Convert a Perl array reference to a SPVM C<byte[]> array. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

If the first argument is a C<undef> value, the return value is a C<undef> value.

=head2 new_byte_array_len

  my $spvm_nums = SPVM::new_byte_array_len([1, 2, 3]);

Create a new SPVM C<byte[]> array with length. The values of elements is zeros. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

The lenght must be greater than or equal to zero. Otherwise an exception will occur.

=head2 new_byte_array_from_bin

  my $perl_binary = pack('c3', 97, 98, 99);
  my $spvm_byte_array = SPVM::new_byte_array_from_bin($perl_binary);

Convert a Perl Binary Data to SPVM byte[] object. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

Thg Perl binary data is interpreted as 8-bit signed integers. The created array length is automatically calcurated from the Perl binary data.

If the first argument is C<undef>, C<undef> is returned.

You can use simple ascii codes as Perl binary data.

  my $perl_binary ="abc";
  my $spvm_byte_array = SPVM::new_byte_array_from_bin($perl_binary);

or UTF-8 bytes.
  
  use utf8;
  my $perl_binary = encode('UTF-8', "あいう");
  my $spvm_string = SPVM::new_string_from_bin($perl_binary);

=head2 new_byte_array_from_string

  use utf8;
  my $spvm_byte_array = SPVM::new_byte_array_from_string("あいう");

Convert a decoded string to SPVM byte[] value using L<utf8::encode|utf8>. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

=head2 new_short_array

  my $spvm_nums = SPVM::new_short_array([1, 2, 3]);

Convert a Perl array reference to a SPVM C<short[]> array. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

If the first argument is a C<undef> value, the return value is a C<undef> value.

=head2 new_short_array_len

  my $spvm_nums = SPVM::new_short_array_len($length);

Create a new  a SPVM C<short[]> array with length. The values of elements is zeros. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

The lenght must be greater than or equal to zero. Otherwise an exception will occur.

=head2 new_short_array_from_bin

  my $perl_binary = pack('c3', 97, 98, 99);
  my $spvm_short_array = SPVM::new_short_array_from_bin($perl_binary);

Convert a Perl Binary Data to SPVM short[] object. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

Thg Perl binary data is interpreted as 16-bit signed integers. The created array length is automatically calcurated from the Perl binary data.

If the first argument is C<undef>, C<undef> is returned.

=head2 new_int_array

  my $spvm_nums = SPVM::new_int_array([1, 2, 3]);

Convert a Perl array reference to a SPVM C<int[]> array. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

If the first argument is a C<undef> value, the return value is a C<undef> value.

=head2 new_int_array_len

  my $spvm_nums = SPVM::new_int_array_len($length);

Create a new  a SPVM C<int[]> array with length. The values of elements is zeros. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

The lenght must be greater than or equal to zero. Otherwise an exception will occur.

=head2 new_int_array_from_bin

  my $perl_binary = pack('l3', 97, 98, 99);
  my $spvm_int_array = SPVM::new_int_array_from_bin($perl_binary);

Convert a Perl Binary Data to SPVM int[] object. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

Thg Perl binary data is interpreted as 8-bit signed integers. The created array length is automatically calcurated from the Perl binary data.

If the first argument is C<undef>, C<undef> is returned.

=head2 new_long_array

  my $spvm_nums = SPVM::new_long_array([1, 2, 3]);

Convert a Perl array reference to a SPVM C<long[]> array. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

If the first argument is a C<undef> value, the return value is a C<undef> value.

=head2 new_long_array_len

  my $spvm_nums = SPVM::new_long_array_len($length);

Create a new  a SPVM C<long[]> array with length. The values of elements is zeros. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

The lenght must be greater than or equal to zero. Otherwise an exception will occur.

=head2 new_long_array_from_bin

  my $perl_binary = pack('q3', 97, 98, 99);
  my $spvm_long_array = SPVM::new_long_array_from_bin($perl_binary);

Convert a Perl Binary Data to SPVM long[] object. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

Thg Perl binary data is longerpreted as 8-bit signed longegers. The created array length is automatically calcurated from the Perl binary data.

If the first argument is C<undef>, C<undef> is returned.

=head2 new_float_array

  my $spvm_nums = SPVM::new_float_array([1.2, 2.5, 3.3]);

Convert a Perl array reference to a SPVM C<float[]> array. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

If the first argument is a C<undef> value, the return value is a C<undef> value.

=head2 new_float_array_len

  my $spvm_nums = SPVM::new_float_array_len($length);

Create a new  a SPVM C<float[]> array with length. The values of elements is zeros. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

The lenght must be greater than or equal to zero. Otherwise an exception will occur.

=head2 new_float_array_from_bin

  my $perl_binary = pack('f3', 0.5, 1.5, 2.5);
  my $spvm_float_array = SPVM::new_float_array_from_bin($perl_binary);

Convert a Perl Binary Data to SPVM float[] object. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

Thg Perl binary data is floaterpreted as 8-bit signed floategers. The created array length is automatically calcurated from the Perl binary data.

If the first argument is C<undef>, C<undef> is returned.

=head2 new_double_array

  my $spvm_nums = SPVM::new_double_array([1.2, 2.5, 3.3]);

Convert a Perl array reference to a SPVM C<double[]> array. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

If the first argument is a C<undef> value, the return value is a C<undef> value.

=head2 new_double_array_len

  my $spvm_nums = SPVM::new_double_array_len($length);

Create a new  a SPVM C<double[]> array with length. The values of elements is zeros. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

The lenght must be greater than or equal to zero. Otherwise an exception will occur.

=head2 new_double_array_from_bin

  my $perl_binary = pack('f3', 0.5, 1.5, 2.5);
  my $spvm_double_array = SPVM::new_double_array_from_bin($perl_binary);

Convert a Perl Binary Data to SPVM double[] object. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

Thg Perl binary data is doubleerpreted as 8-bit signed doubleegers. The created array length is automatically calcurated from the Perl binary data.

If the first argument is C<undef>, C<undef> is returned.

=head2 new_string

  use utf8;
  my $spvm_string = SPVM::new_string("あいう");

Convert a Perl string to a SPVM string.

If the argument is C<undef>, C<undef> is returned.

=head2 new_string_from_bin

  my $perl_binary = pack('c3', 97, 98, 99);
  my $spvm_string = SPVM::new_string_from_bin($perl_binary);

Convert a Perl Binary Data to SPVM string object. Return value is L<SPVM::BlessedObject::String> object which wraps the SPVM string.

Thg Perl binary data is interpreted as 8-bit signed integers. The string length is automatically calcurated from the Perl binary data.

If the first argument is C<undef>, C<undef> is returned.

You can use simple ascii codes as Perl binary data.

  my $binary ="abc";
  my $spvm_string = SPVM::new_string_from_bin($perl_binary);

or UTF-8 bytes.

  use utf8;
  my $perl_binary = encode('UTF-8', "あいう");
  my $spvm_string = SPVM::new_string_from_bin($perl_binary);

=head2 new_any_object_array

  my $byte_array = SPVM::new_any_object_array(
    [SPVM::Byte->new(1), SPVM::Byte>new(2), SPVM::Byte->new(3)]
  );

The alias for the following code using L</"new_object_array">.

  my $spvm_array = SPVM::new_object_array('object[]', $perl_array_ref);

=head2 new_object_array

  my $byte_array = SPVM::new_object_array(
    "SPVM::Byte[]",
    [SPVM::Byte->new(1), SPVM::Byte>new(2), SPVM::Byte->new(3)]
  );

Convert a Perl array reference to a SPVM object array. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

The first argument is a SPVM array type name. If the type is non-existent, an exception occurs.

The second argument is a Perl array reference. Each element must be valid value or C<undef>. Otherwise an exception will occur.

Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

You can also create multidimensional array.

  my $object1 = SPVM::new_int_array([1, 2, 3]);
  my $object2 = SPVM::new_int_array([4, 5, 6]);
  my $objects = SPVM::new_object_array("int[][]",[$object1, $object2]);

=head2 new_mulnum_array

Convert a Perl array references to SPVM multi-numeric array.

  my $perl_values = [
    {x => 0, y => 1, z => 2},
    {x => 3, y => 4, z => 5},
    {x => 6, y => 7, z => 8},
  ];
  my $spvm_mulnum_array = SPVM::new_mulnum_array("TestCase::Point_3i[]", $perl_values);

The first argument is a SPVM array type name. If the type is non-existent, an exception occurs.

The second argument is a Perl array of hash references. Each hash reference must be contain all fields of the multi-numeric value. Otherwise an exception will occur.

Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

B<Examples:>

  # new_mulnum_array - byte
  {
    my $values = [
      {x => 0, y => 1, z => 2},
      {x => 3, y => 4, z => 5},
      {x => 6, y => 7, z => 8},
    ];
    my $spvm_mulnum_array = SPVM::new_mulnum_array("TestCase::Point_3b[]", $values);
  }

  # new_mulnum_array - short
  {
    my $values = [
      {x => 0, y => 1, z => 2},
      {x => 3, y => 4, z => 5},
      {x => 6, y => 7, z => 8},
    ];
    my $spvm_mulnum_array = SPVM::new_mulnum_array("TestCase::Point_3s[]",$values);
  }

  # new_mulnum_array - int
  {
    my $values = [
      {x => 0, y => 1, z => 2},
      {x => 3, y => 4, z => 5},
      {x => 6, y => 7, z => 8},
    ];
    my $spvm_mulnum_array = SPVM::new_mulnum_array("TestCase::Point_3i[],$values);
  }

  # new_mulnum_array - long
  {
    my $values = [
      {x => 0, y => 1, z => 2},
      {x => 3, y => 4, z => 5},
      {x => 6, y => 7, z => 8},
    ];
    my $spvm_mulnum_array = SPVM::new_mulnum_array("TestCase::Point_3l[]", $values);
  }

  # new_mulnum_array - float
  {
    my $values = [
      {x => 0, y => 1, z => 2},
      {x => 3, y => 4, z => 5},
      {x => 6, y => 7, z => 8},
    ];
    my $spvm_mulnum_array = SPVM::new_mulnum_array("TestCase::Point_3f[]",$values);
  }

  # new_mulnum_array - double
  {
    my $values = [
      {x => 0, y => 1, z => 2},
      {x => 3, y => 4, z => 5},
      {x => 6, y => 7, z => 8},
    ];
    my $spvm_mulnum_array = SPVM::new_mulnum_array("TestCase::Point_3d[],"$values);
    ok(SPVM::TestCase::ExchangeAPI-spvm_new_mulnum_array_double($spvm_mulnum_array));
    my $out_values = $spvm_mulnum_array->to_elems;
    is_deeply($out_values, $values);
  }

=head2 new_mulnum_array_from_bin

  my $binary = pack('l9', ($INT_MIN, 1, 2), (3, 4, 5), (6, 7, 8));
  my $spvm_mulnum_array = SPVM::new_mulnum_array_from_bin("TestCase::Point_3i[]", $binary);

Convert Perl a binary data to SPVM Multi Numeric Array. Return value is L<SPVM::BlessedObject::Array> object which wraps the SPVM array.

The first argument is a multi-numeric array type of SPVM.

The second argument is the Perl packed binary data. The length of the created array is calcurated automatically.

B<Examples:>
  
  # new_mulnum_array_from_bin - byte
  {
    my $binary = pack('c9', (0, 1, 2), (3, 4, 5), (6, 7, 8));
    my $spvm_mulnum_array = SPVM::new_mulnum_array_from_bin("TestCase::Point_3b[]", $binary);
  }

  # new_mulnum_array_from_bin - short
  {
    my $binary = pack('s9', (0, 1, 2), (3, 4, 5), (6, 7, 8);;
    my $spvm_mulnum_array = SPVM::new_mulnum_array_from_bin("TestCase::Point_3s[]", $binary);
  }

  # new_mulnum_array_from_bin - int
  {
    my $binary = pack('l9', (0, 1, 2), (3, 4, 5), (6, 7, 8));
    my $spvm_mulnum_array = SPVM::new_mulnum_array_from_bin("TestCase::Point_3i[]", $binary);
  }

  # new_mulnum_array_from_bin - long
  {
    my $binary = pack('q9', (0, 1, 2), (3, 4, 5), (6, 7, 8));
    my $spvm_mulnum_array = SPVM::new_mulnum_array_from_bin("TestCase::Point_3l[]", $binary);
  }

  # new_mulnum_array_from_bin - float
  {
    my $binary = pack('f9', (0, 1, 2), (3, 4, 5), (6, 7, 8));
    my $spvm_mulnum_array = SPVM::new_mulnum_array_from_bin("TestCase::Point_3f[]", $binary);
  }

  # new_mulnum_array_from_bin - double
  {
    my $binary = pack('d9', (0, 1, 2), (3, 4, 5), (6, 7, 8));
    my $spvm_mulnum_array = SPVM::new_mulnum_array_from_bin("TestCase::Point_3d[]", $binary);
  }

=head2 get_exception

  my $exception = SPVM::get_exception();

Get the exception of the SPVM runtime environment as L<SPVM::BlessedObject::String> object.

=head2 set_exception

Set a SPVM exception of the SPVM runtime environment.

The argument must be a L<SPVM::BlessedObject::String> object, a decoded string or C<undef>. Otherwise an exception will occur.

  SPVM::set_exception(SPVM::new_string("abc"));
  SPVM::set_exception("abc");
  SPVM::set_exception(undef);

=head2 get_memory_blocks_count

  my $count = SPVM::get_memory_blocks_count();

Get the count of created memory blocks. SPVM runtime create a memory block on the heap when a object is created or new week reference is created.

You can check the memory leaks by this method.

  # First Memory Blocks Count
  my $start_memory_blocks_count = SPVM::get_memory_blocks_count();

  # Processing
  # ...

  # Last Memory Blocks Count
  my $end_memory_blocks_count = SPVM::get_memory_blocks_count();

  unless ($end_memory_blocks_count == $start_memory_blocks_count) {
    die"Memroy leak";
  }
