# Mysh

Inspired by the excellent article "Writing a Shell in 25 Lines of Ruby Code"
I thought it would be fun to experiment with that concept and see if it could
be taken further.

Many years ago, a popular shell program was modeled after
the 'C' programming language. It went by the csh for C-shell (by the C shore :-)
Instead of 'C', my shell would be based on Ruby (were you shocked?)!  The
obvious name rsh for Ruby-shell was already in use by the Remote-shell. So,
given the limited scope of this effort, and not wanting to do a lot of typing
all the time, I chose the name mysh for My-shell.

Since that name was available, it would seem that no one had yet written a
shell program at this level of narcissism.

The mysh is available as both a stand-alone CLI program and for use as a
command shell within Ruby applications and Rails web sites.

See the original article at:
(http://www.blackbytes.info/2016/07/writing-a-shell-in-ruby/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mysh'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mysh

## Usage

The mysh gem includes a simple executable called mysh. When run, the user is
presented with a command prompt:

    Peter Camilleri@NCC1701G ~
    $ mysh
    mysh>


This prompt can be used to execute four sorts of commands:

* Internal commands that are processed directly by mysh
* Ruby expressions, which are preceded by the equal (=) sign.
* External ruby source files that are passed on to the Ruby interpreter.
* External commands that are passed on to the standard command shell.

From the mysh help:

    mysh> ?
    mysh (MY ruby SHell) version: 0.1.11

    1) Internal mysh commands:
     - executed by mysh directly.
     - supports the following set of commands.

       Internal Commands
      ===================

    !         Display the mysh command history.
    ?         Display help information for mysh.
    cd <dir>  Change directory to the optional <dir> parameter.
              Then display the current working directory.
    exit      Exit mysh.
    help      Display help information for mysh.
    history   Display the mysh command history.
    pwd       Display the current working directory.
    quit      Exit mysh.

    2) Ruby Expression support:
     - any line beginning with an equals "=" sign will be evaluated as a Ruby
       expression. This allows the mysh command line to serve as a programming,
       debugging and super-calculator environment.
     - for more info use the 'help ruby' command.

    3) Math support:
     - the execution environment includes the Math module.
     - for more info use the 'help math' command.

    4) External commands:
     - executed by the system using the standard shell.
     - to force the use of the external shell, add a leading space to the command.

    Note: If the command has a '.rb' extension it is executed by Ruby.
          So the command "myfile.rb" is executed as "ruby myfile.rb"

and

    mysh> ? ruby
    mysh (MY ruby SHell) version: 0.1.11

    mysh Ruby expression support summary

     - All command lines that begin with an equals "=" sign are evaluated as Ruby
       expressions.
     - Expressions ending with a backslash character "\" are continued on the next
       line. The prompt changes to "mysh\" to indicate that this is going on.
     - The results are displayed using the pretty-print facility.
     - Auto-complete always places any file names in quotes so they can be used
       as string parameters.

    A few noteworthy methods exist that facilitate use of Ruby expressions:

    reset      Reset the execution environment to the default state.
    result     Returns the result of the previous expression.
    vls <mask> List modules with version info. The optional mask string value
               is used to filter for modules containing that string.

and

    mysh> ? math
    mysh (MY ruby SHell) version: 0.1.11

    mysh Math support summary

    The Ruby expression execution environment has direct access to many advanced
    Math functions. For example, to compute the cosine of 3.141592653589793 use:

      mysh> =cos(PI)
      -1.0

    Method     Returns Description
    =======    ======= ================================================
    acos(x)    Float   Computes the arc cosine of x. Returns 0..PI.
    acosh(x)   Float   Computes the inverse hyperbolic cosine of x.
    asin(x)    Float   Computes the arc sine of x. Returns -PI/2..PI/2.
    asinh(x)   Float   Computes the inverse hyperbolic sine of x.
    atan(x)    Float   Computes the arc tangent of x. Returns -PI/2..PI/2.
    atan2(y,x) Float   Computes the arc tangent given y and x.
                       Returns a Float in the range -PI..PI.
    atanh(x)   Float   Computes the inverse hyperbolic tangent of x.
    cbrt(x)    Float   Returns the cube root of x.
    cos(x)     Float   Computes the cosine of x (expressed in radians).
                       Returns a Float in the range -1.0..1.0.
    cosh(x)    Float   Computes the hyperbolic cosine of x (expressed in radians).
    erf(x)     Float   Calculates the error function of x.
    erfc(x)    Float   Calculates the complementary error function of x.
    exp(x)     Float   Returns e**x.
    frexp(x)   Array   Returns a two-element array containing the normalized
                       fraction (a Float) and exponent (a Fixnum) of x.
    gamma(x)   Float   Calculates the gamma function of x.
    hypot(x,y) Float   Returns sqrt(x**2 + y**2), the hypotenuse of a right-angled
                       triangle with sides x and y.
    ldexp(f,e) Float   Returns the value of f*(2**e).
    lgamma(x)  Array   Returns a two-element array containing the log of the
                       gamma of x and the sign of gamma of x.
    log(x)     Float   Computes the natural log of x.
    log(x,B)   Float   Computes the base B log of x.
    log10(x)   Float   Returns the base 10 logarithm of x.
    log2(x)    Float   Returns the base 2 logarithm of x.
    sin(x)     Float   Computes the sine of x (expressed in radians).
                       Returns a Float in the range -1.0..1.0.
    sinh(x)    Float   Computes the hyperbolic sine of x (expressed in radians).
    sqrt(x)    Float   Returns the non-negative square root of x.
    tan(x)     Float   Computes the tangent of x (expressed in radians).
    tanh(x)    Float   Computes the hyperbolic tangent of x (expressed in radians).

    PI         Float   The value 3.141592653589793
    E          Float   The value 2.718281828459045

The mysh can also be used from within a Ruby application:

```ruby
Mysh.run
```

## Adding New Commands

It is possible to add new internal commands to the mysh CLI. This is done by
depositing the appropriate ruby file in the commands folder located at:

  /mysh/lib/mysh/commands

As an example, the file cd.rb is shown to illustrate the responsibilities of
a typical command plug-in:

```ruby
# coding: utf-8

#* commands/cd.rb -- The mysh internal cd command.
module Mysh

  #* cd.rb -- The mysh internal cd command.
  class InternalCommand
    #Add the cd command to the library.
    desc = ['Change directory to the optional <dir> parameter.',
            'Then display the current working directory.']

    add('cd <dir>', desc) do |args|
      begin
        Dir.chdir(args[0]) unless args.empty?
        puts decorate(Dir.pwd)
      rescue => err
        puts "Error: #{err}"
      end
    end

    #Add the pwd command to the library.
    add('pwd', 'Display the current working directory.') do |args|
      begin
        puts decorate(Dir.pwd)
      rescue => err
        puts "Error: #{err}"
      end
    end

  end
end
```

Note that the plug in code is contained within the InternalCommand class under
the Mysh module umbrella. The principle method used to create internal commands
is the add method:

```ruby
add(command_name, command_description) do |args|
  # Action block goes here
end
```
Where:
* command_name is the name of the command with optional argument descriptions
seperated with spaces. The command is the first word of this string.
* command_description is a string or an array of strings that describe the
command.
* args is an array of zero or more arguments that were entered with the command.

Commands sometimes have more than one possible name. This is supported with:

```ruby
add_alias(new_name, old_name)
```


## Contributing

#### Plan A

1. Fork it ( https://github.com/PeterCamilleri/mysh/fork )
2. Switch to the development branch ('git branch development')
3. Create your feature branch ('git checkout -b my-new-feature')
4. Commit your changes ('git commit -am "Add some feature"')
5. Push to the branch ('git push origin my-new-feature')
6. Create new Pull Request

#### Plan B

Go to the GitHub repository at (https://github.com/PeterCamilleri/mysh) and
raise an issue calling attention to some aspect that could use some TLC or a
suggestion or an idea.
