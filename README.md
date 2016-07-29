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

  mysh>

This prompt can be used to execute three sorts of commands:

* Internal commands that are processed directly by mysh
* Ruby expressions, which are preceded by the equal (=) sign.
* External commands that are passed on to the standard command shell.

From the mysh help:

    mysh> ?
    mysh (MY SHell) version: 0.1.0

    Internal mysh commands:
     - executed by mysh directly.
     - a leading space skips all internal commands.

    !           Display the mysh command history.
    =an_expr    Display the result of evaluating an expression in ruby.
    =result     Display the result of the previous evaluation.
    =stuff \    This expression is continued on the next line.
    ?           Display help information for mysh.
    cd <dir>    Change directory to <dir> and display the new working directory.
    exit        Exit mysh.
    help        Display help information for mysh.
    history     Display the mysh command history.
    pwd         Display the current working directory.
    quit        Exit mysh.

    Math support:
     - the execution environment includes the Math module.
     - for more info use the help math command.

    External commands:
     - executed by the system using the standard shell.
     - use help - for more info on external commands.

and

    mysh> ? math
    mysh (MY SHell) version: 0.1.0

    mysh Math support summary

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
    log(x)     Float   Computes the natural log of c.
    log(x,B)   Float   Computes the base B log of c.
    log10(x)   Float   Returns the base 10 logarithm of x.
    log2(x)    Float   Returns the base 2 logarithm of x.
    sin(x)     Float   Computes the sine of x (expressed in radians).
                       Returns a Float in the range -1.0..1.0.
    sinh(x)    Float   Computes the hyperbolic sine of x (expressed in radians).
    sqrt(x)    Float   Returns the non-negative square root of x.
    tan(x)     Float   Computes the tangent of x (expressed in radians).
    tanh(x)    Float   Computes the hyperbolic tangent of x (expressed in radians).


The mysh can also be used from within a Ruby application:

```ruby
Mysh.run
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
