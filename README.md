# Mysh

mysh -- A ruby based command line shell program.

## Background

Inspired by the excellent article "Writing a Shell in 25 Lines of Ruby Code"
I thought it would be fun to experiment with that concept and see if it could
be taken further.

Many years ago, a popular shell program was modeled after the 'C' programming
language. It went by the name csh for C-shell (by the C shore :-) Instead of
'C', my shell would be based on Ruby (were you shocked?)! The obvious name rsh
for Ruby-shell was already in use by the Remote-shell. So, given the limited
scope of this effort, and not wanting to do a lot of typing all the time, I
chose the name mysh for MY-SHell.

Since that name was available, it would seem that no one had yet written a
shell program at this level of narcissism.

The mysh is available as both a stand-alone CLI program and for use as a
command shell within Ruby applications and (maybe? eventually? someday?) Rails
web sites.

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

The mysh gem includes a simple executable called mysh. The template for running
the mysh is:

```
mysh <args>
```

Where args are currently a work in progress and not available at this time.

When mysh is run, the user is presented with a command prompt:

```
$ mysh
/cygdrive/c/Sites/mysh
mysh>

```
Now the user (that's you) may enter commands that hopefully increase the level
of awesome coolness in the known universe. Entropy does not take vacations so
hop to it! :-)

###REPL

Now for a little more detail. The mysh program is built around a design pattern
called REPL. This stands for Read Eval Print and Loop and is used in may
utilities like irb, pry and the rails console. To better use mysh, it is good
to understand each of these four operating steps.

####READ

The first step is just to get input from the user. For interactive sessions
this is done using the mini_readline gem. The user is prompted and input is
obtained. There is a twist here. Just what constitutes a unit of input?
Normally an input is one line entered by the user. Like this:

```
mysh> ls *.rb
```
In mysh, the user is able to chain together multiple lines and have them
treated as a single input. So for the following scenario:
```
mysh>line one\
mysh\line two\
mysh\line three
```
The input string will be:
```
"line one\nline two\nline three\n"
```
Note that while the prompt is user configurable, it will always end with '>'
for the initial line and '\\' for subsequent lines.

For more information about the mini_readline gem please see
https://github.com/PeterCamilleri/mini_readline or
https://rubygems.org/gems/mini_readline

####EVAL

Once input has been obtained from the user, that input is then evaluated. This
evaluation has two phases: pre-processing and processing.

#####Input Preprocessing

During pre-processing, the input is scanned for macro-like substitutions that
have been placed into the input. There are three steps to this phase:

1. Replacing mysh variables with their values. This process is recursive in
that these variables also undergo the full pre-processing treatment before
being inserted into the user command.
2. Replacing embedded ruby "handlebars" with the results of their execution.
3. Replacing '\\{' and '\\}' with '{' and '}' respectively.

#####Command Processing

Once input has been obtained and massaged adequately, it's time to actually
do some work. In mysh there is a hierarchy of four types of commands. These
command types serve as a simple command path for determining what action is to
be taken for the input. The four types are:

1. Quick Commands - These commands are recognized by having a signature first
character in the input. These signature characters are:
  * ! to access the mysh command history buffer.
  * $ to access or update mysh variables.
  * = to evaluate an expression of Ruby code.
  * ? to access the mysh help subsystem.
  * @ to get information about the system, its environment, and the ruby
  installation

2. Internal Commands - These commands are recognized by having the first word
in the input match a word stored in an internal hash of command actions.
3. External Ruby Commands - These commands are recognized by having the first
word in the input have the extension (*.rb) of a ruby source file.
4. External Commands - Any command not matching any of the above is sent to the
system shell for execution.

Notes:
* The recursive pre-processing steps have checks on them to detect loops and
other forms of bad behavior before they do nasty things like blow up the stack.
* The mysh variables are also used to control many aspects of the mysh and are
covered in their own section below.
* The embedded ruby "handlebars" also get their own section below.

####PRINT

####LOOP

The processing of input continues (looping) until it doesn't. This occurs when
a command to stop looping is entered or the mini_readline gem signals
end-of-input condition. The commands that do this are:

* exit - exit the current mysh level.
* quit - terminate the mysh program.

Work-in-progress - mysh only has one level at this time so these two commands
do exactly the same thing... for now!

An end-of-input condition is signaled by the user by entering Ctrl-z (in
windows) or Alt-z (in Linux/Mac). See the mini_readline gem (link above) for
more information on the keyboard mappings used by mysh.


===================================================


#### Ruby expressions:

* Any line beginning with an equals "=" sign will be evaluated as a Ruby
  expression. This allows the mysh command line to serve as a programming,
  debugging and super-calculator environment.
* Expressions ending with a backslash character "\" are continued on the next
  line. The prompt changes to end with a "\" character to indicate that this is
  going on.
* The results are displayed using the pretty-print facility.
* Auto-complete always places any file names in quotes so they can be used
  as string parameters.

A few noteworthy methods exist that facilitate use of Ruby expressions:
```
reset      Reset the execution environment to the default state.
result     Returns the result of the previous expression.
x.lineage  Get the class lineage of the object x.
```
For example:
```
mysh>=a=42
42
mysh>=a
42
mysh>=result
42
mysh>=a.lineage
"42 of Fixnum < Integer < Numeric < Object < BasicObject"
mysh>=reset

mysh>=a
NameError: undefined local variable or method `a' for exec_host:#<Class:0x1ba8720>
mysh>=result

mysh>
```



The Ruby expression execution environment has direct access to many advanced
Math functions. For example, to compute the cosine of 3.141592653589793 use:
```
mysh> =cos(PI)
-1.0
```

The following table describes the available math functions.

Function   |Type  |Description
-----------|------|-----------------------------------------------------
acos(x)    |Float |The arc cosine of x. Returns 0..&#960;.
acosh(x)   |Float |The inverse hyperbolic cosine of x.
asin(x)    |Float |The arc sine of x. Returns -&#960;/2..&#960;/2.
asinh(x)   |Float |The inverse hyperbolic sine of x.
atan(x)    |Float |The arc tangent of x. Returns -&#960;/2..&#960;/2.
atan2(y,x) |Float |The arc tangent given y and x. Returns -&#960;..&#960;.
atanh(x)   |Float |The inverse hyperbolic tangent of x.
cbrt(x)    |Float |The cube root of x. (&#8731;x)
cos(x)     |Float |The cosine of x (in radians). Returns -1.0..1.0.
cosh(x)    |Float |The hyperbolic cosine of x (in radians).
erf(x)     |Float |The error function of x.
erfc(x)    |Float |The complementary error function of x.
exp(x)     |Float |Raise e to the power of x. (e<sup>x</sup>).
frexp(x)   |Array |Extracts a two-element array containing [fraction, exponent].
gamma(x)   |Float |The gamma function of x. (&#915;x).
hypot(x,y) |Float |The hypotenuse of a right-angled triangle. &#8730;(x&#178; + y&#178;)
ldexp(m,e) |Float |Builds a value where f is the fraction and e is the exponent.
lgamma(x)  |Array |Builds a two-element array [ln(&#124;&#915;x&#124;), sign(&#915;x)]
log(x)     |Float |The natural log of x. (log<sub>e</sub> x) or (ln x).
log(x,b)   |Float |The base b log of x. (log<sub>b</sub> x).
log10(x)   |Float |The base 10 log of x. (log<sub>10</sub> x).
log2(x)    |Float |The base 2 log of x. (log<sub>2</sub> x).
sin(x)     |Float |The sine of x (in radians). Returns -1.0..1.0.
sinh(x)    |Float |The hyperbolic sine of x (in radians).
sqrt(x)    |Float |The non-negative square root of x. (&#8730;x).
tan(x)     |Float |The tangent of x (in radians).
tanh(x)    |Float |The hyperbolic tangent of x (in radians).
E          |Float |The value e (2.718281828459045)
PI         |Float |The value &#960; (3.141592653589793)

#### Internal mysh commands:

Internal commands are recognized by name and are executed by mysh directly.

The following set of commands are supported:

```
!<index>        Display the mysh command history, or if an index is specified,
                retrieve the command with that index value.
?<topic>        Display help information for mysh with an optional topic.
@<item>         Display information about a part of mysh. See ?@ for more.
cd <dir>        Change directory to the optional <dir> parameter and then
                display the current working directory.
exit            Exit mysh.
gls <-l> <mask> Display the loaded ruby gems. See ?gls for more.
help <topic>    Display help information for mysh with an optional topic.
history <index> Display the mysh command history, or if an index is specified,
                retrieve the command with that index value.
pwd             Display the current working directory.
quit            Exit mysh.
show <item>     Display information about a part of mysh. See ?@ for more.
type            Display a text file with optional embedded handlebars.
vls <mask>      Display the loaded modules, matching the optional mask, that
                have version info.
```
Of note is the command "help help" or "??" which provides a list of all
available help topics.

```
Help: mysh help command summary:

The help (or ?) command is used to get either general help about mysh or an
optional specified topic.

If the longer form, help is used, a space is required before the topic. If the
quick form, ? is used, the space is optional.

The available help topics are:

        General help on mysh.
!       This help on the history command.
=       Help on ruby expressions.
?       This help on the help command.
@       Help on the show command.
env     Help on the show env command.
gls     Help on gls internal mysh command.
help    This help on the help command.
history This help on the history command.
kbd     Help on mysh keyboard mapping.
math    Help on math functions.
quick   Help on quick commands.
ruby    Help on the show ruby command.
show    Help on the show command.
{{      Help on mysh handlebars.
```

#### External commands:

All other commands are executed by the system using the standard shell or
the appropriate ruby interpreter.

Notes:
* If an internal command has the same name as an external command, adding a
  leading space will force the use of the external command.
* If the command has a '.rb' extension, it is executed by the appropriate ruby
  interpreter. The interpreter used is the one specified by RbConfig.ruby

## Embedding mysh in an application.

The mysh can also be used from within a Ruby application:

```ruby
require "mysh"

#Some stuff omitted.

Mysh.run
```

#### Adding New Commands

It is possible to add new internal commands to the mysh CLI. This may done
manually by depositing the appropriate ruby file in the actions folder
located at:

    <gem_root>/mysh/lib/mysh/internal/actions

A survey of the contents of that folder will reveal the nature of these files.

New internal commands may also be added in code via the the add_action method
of the InternalCommand class of the Mysh module. The code to do this would look
something like this:

```ruby
module Mysh
  class NewCommand < Action

    #This method is called when the command is executed.
    def call(args)
    end


  end

  desc = "A succinct description of what this command does."
  command_name = 'new <item>'
  COMMANDS.add_action(NewCommand.new(command_name, desc))

end
```

Where:
* command_name is the name of the command with optional argument descriptions
separated with spaces. The command is the first word of this string. For
example a command_name of:

```
"new <item>"
```

will create a command called "new" with a title of "new &#60;item&#62;"

* command_description is a string or an array of strings that describe the
command. This serves as the descriptive help for the command. The help display
code handles matters like word wrap automatically.

#### About command args

The call method take one parameter called args. The args parameter is an array
of zero or more arguments that were entered with the command.

So if a command is given

    command abc "this is a string" 23 --launch --all

the args array will contain:

    ["abc", "this is a string", "23", "--launch", "--all"]

## Contributing

All participation is welcomed. There are two fabulous plans to choose from:

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
suggestion or an idea or a comment.

This is a low pressure environment. All are welcome!
