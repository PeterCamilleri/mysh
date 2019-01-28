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

Oh, and one other little thing. A survey of the mysh reveals that it currently
contains 2188 lines of code. It seems that there has been some growth beyond
the 25 lines in the original article.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mysh'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mysh


#### Advanced Options

As a gem, when mysh is installed, the mysh file in the bin directory gets
"hooked in" to the system as an executable file. In Mac/Linux systems this is
done natively. In Windows systems this is done via an intermediary mysh.bat
file. This works, but leaves a great deal to be desired especially in its
handling of signals like control-C. Since Windows users are treated as hated
step-sisters, here are two alternative options to using mysh as your shell
once the Ruby language and the mysh gem have been installed.

---

**Option 1 - Against a standard Ruby install**

This option applies if Ruby is installed so that it is generally available in
any command window. You can test this by opening a regular command line window
and typing:

    ruby -v

You should see the ruby's version info. If instead you see:

    C:\Users\Hilda>ruby -v
    'ruby' is not recognized as an internal or external command,
    operable program or batch file.

Then there are either installation issues with Ruby or you need to see option 2.

Once Ruby operation is confirmed, all that is needed is to get a copy of the
Command Window Icon and update the target field in its properties as:

OLD

    %windir%\system32\cmd.exe

NEW

    %windir%\system32\cmd.exe /C ruby -e"require %q{mysh}; Mysh.run"

---

**Option 2 - Against a RailsInstaller install**

With RailsInstaller (RI) things are a teensy bit more involved. RI creates a
special Command Prompt with Ruby and Rails icon. To start you need to make a
copy of that icon. Then the target field in properties needs to be updated:

OLD

    C:\Windows\System32\cmd.exe /E:ON /K C:\RailsInstaller\Ruby2.3.3\setup_environment.bat C:\RailsInstaller

NEW

    C:\Windows\System32\cmd.exe /E:ON /C C:\RailsInstaller\Ruby2.3.3\setup_environment.bat C:\RailsInstaller & ruby -e"require %q{mysh}; Mysh.run"

Note: The change from /K to /C.

---

**Also** For both options, renaming the icon to something like
"Mysh with Ruby and Rails" or some such is also a good idea. Then make sure you
place your icon where you can find it. I pinned mine to the Windows Task Bar.

---

## Usage

The mysh gem includes a simple executable called mysh. The template for running
the mysh is:

```
mysh <options>
```

Where the available options are:

Option               | Short Form(s)| Description             | Default
---------------------|--------------|-------------------------|-----------
--debug              | -d           | Turn on mysh debugging. | false
--do-move            |              | Turn on mysh command history shifting.
--no-move            |              | Turn off mysh command history shifting. | true
--no-debug           | -nd          | Turn off mysh debugging.
--help               | -? -h        | Display mysh usage info and exit.
--history            |              | Turn on mysh command history. | true
--no-history         |              | Turn off mysh command history.
--init filename      | -i filename  | Initialize mysh by loading the specified file. | ~/mysh_init.mysh
--no-init            | -ni          | Do not load a file to initialize mysh.
--load filename      | -l filename  | Load the specified file into the mysh.
--pause              |              | Enable page pauses for long output.
--no-pause           |              | Disable page pauses for long output.
--post-prompt "str"  | -pp "str"    | Set the mysh line continuation prompt to "str". | $prompt
--no-post-prompt     | -npp         | Turn off mysh line continuation prompting.
--pre-prompt "str"   | -pr "str"    | Set the mysh pre prompt to "str". | $w
--no-pre-prompt      | -npr         | Turn off mysh pre prompting.
--prompt "str"       | -p "str"     | Set the mysh prompt to "str". | mysh
--no-prompt          | -np          | Turn off mysh prompting.
--quit               |              | Quit out of the mysh program.

<br>When mysh is run, the user is presented with a command prompt:

```
$ mysh
/cygdrive/c/Sites/mysh
mysh>
```

Now the user (that's you) may enter commands that hopefully increase the level
of awesome coolness in the known universe. Entropy does not take vacations so
hop to it! :-)

Now that we've launched mysh, what exactly does it do? This can be summarized
with just two words: Boot and REPL.

### Boot

When mysh starts up, it, like most programs must first get itself initialized
and acclimated to its environment. The boot/initialization  process of mysh is
somewhat modeled after (well if I'm honest, more like inspired by) that of the
famous bash shell. On startup:

1. Option values are initialized to their initial, default values.
2. Process pre-boot command line options: Some command line options are
processed early. These are --help, -h, -?, --init, -i, --no-init, and -ni.
See Usage above for details on these.
3. Try to load and execute the mysh_init file. There are three possible files
for this role. They are ~/mysh_init.mysh, ~/mysh_init.rb, and ~/mysh_init.txt.
In priority, ".mysh" > ".rb" > ".txt". <br>NOTE: If an init file should be
specified with the --init option, or disabled with the --no-init option, this
step is skipped.
4. The rest of the command line options are processed at this time. Again,
see Usage above for details.

It should be noted that in the event of a conflict in settings during the boot
process, the last command/option encountered shall prevail. For example if the
~/mysh_init.mysh contains the line:
```
set $debug = on
```
and the command line has the -nd option, then debug mode will be disabled
because the -nd command line option is processed after the mysh_init file.

### REPL

Now for a little more detail about what happens after booting up. The mysh
program is built around a design pattern called REPL. This stands for Read Eval
Print and Loop and is used in may utilities like irb, pry and the rails
console. To better use mysh, it is good to understand each of these four
operating steps.

For more information on REPLs please see:
(https://en.wikipedia.org/wiki/Read-eval-print_loop) and
(https://repl.it/languages/ruby)

#### READ

The first step is just to get input from the user. For interactive sessions
this is done using the mini_readline gem. The user is prompted and input is
obtained. There is a twist here. Just what constitutes a unit of input?
Normally an input is one line entered by the user. Like this:

```
mysh> ls *.rb
```
In mysh, the user is able enter Ruby code directly at the command line. Since
these commands can be rather long, there is a need to to chain together
multiple lines and have them treated as a single input. So for the following
scenario:
```
mysh>= "line one" +\
mysh\"line two" +\
mysh\"line three"
```
The input string will be:
```
"="line one" +\n"line two" +\n"line three"\n"
```
Note that while the prompt is user configurable, it will always end with '>'
for the initial line and '\\' for subsequent lines.

For more information about the mini_readline gem please see
https://github.com/PeterCamilleri/mini_readline or
https://rubygems.org/gems/mini_readline

#### EVAL

Once input has been obtained from the user, that input is then evaluated. This
evaluation has two phases: pre-processing and processing.

##### Input Preprocessing

During pre-processing, the input is scanned for macro-like substitutions that
have been placed into the input. There are three steps to this phase:

1. Replacing mysh variables with their values. This process is recursive in
that these variables also undergo the full pre-processing treatment before
being inserted into the user command.
2. Replacing embedded ruby "handlebars" with the results of their execution.
3. Replacing '\\{' and '\\}' with '{' and '}' respectively.

##### Command Processing

Once input has been obtained and massaged adequately, it's time to actually
do some work. In mysh there is a hierarchy of four types of commands. These
command types serve as a simple command path for determining what action is to
be taken for the input. The four types are:

1. Quick Commands - These commands are recognized by having a signature first
character in the input. These signature characters are:
  * ! to access the mysh command history buffer. For more information see
  Command History below.
  * \# a comment. Performs no operation.
  * $ to access or update mysh variables. For more information see Shell
  Variables below.
  * % to execute a command and then display the elapsed execution time.
  * = to evaluate an expression of Ruby code. For more information see Ruby
  Expressions below.
  * ? to access the mysh help subsystem. For more information see Shell Help
  below.
  * @ to get information about the system, its environment, and the ruby
  installation. For more information see Shell Info below.
2. Internal Commands - These commands are recognized by having the first word
in the input match a word stored in an internal hash of command actions. For
more information see Internal Commands below.
3. External mysh files - These commands are recognized by having the first
word in the input have a recognized extension. That is (*.rb) of a ruby source
file, (*.mysh) for a mysh script file and (*.txt) for a text file. For more
information see External Mysh Commands below.
4. External Commands - Any command not matching any of the above is sent to the
system shell for execution. For more information see External Commands below.

Notes:
* The recursive pre-processing steps have checks on them to detect loops and
other forms of bad behavior before they do nasty things like blow up the stack.
* The mysh variables are also used to control many aspects of the mysh and are
covered in their own section below.
* The embedded ruby "handlebars" also get their own section below.

#### PRINT

Once the command is run, some results are expected most of the time. For Ruby
expressions, this is handled by the pretty print gem. The 'pp' function is
given the value returned by the expression just evaluated. For other types
of command, the command itself generates any required output.

To assist in the creation of well formatted output, the mysh environment
provides a number of "helper" methods in the Array and String classes. These
are:

* String#to_host_spec - given a string with a file path/name value, express that
string in a manner compatible with the current operating environment.

###### Formatting

To assist in creating nicely formatted output, the mysh employs the
format_output gem. Please refer to that gem for more information.

###### Page Pause

Some commands can generate very lengthy output that can scroll off the top of
the screen. To handle this, mysh automatically inserts pauses once per screen.
Now this capability has been moved into the pause_output gem, but since it has
an impact on the user "experience" it is discussed here. When a pause point is
reached, mysh displays a prompt and waits for the users to press a key that
will determine the action to take. The default pause prompt message is:

    Press a key, a space, or q:

The available actions are:

Key        | Action
-----------|-----------------------------------------------
'q' or "Q" | Stop the long winded command.
Space      | Add a single line of additional output.
Other      | Add up to a whole page of additional output.

This feature is controlled by the $page_pause variable that can be either
on or off as well as the --pause and --no-pause command line options.

#### LOOP

The processing of input continues (looping) until it doesn't. This occurs when
a command to stop looping is entered or the mini_readline gem signals
end-of-input condition. The (internal) commands that do this are:

* cancel - exit the current mysh file/level.
* exit - terminate the mysh program.

The cancel and exit commands are also available, with the same names and
behavior, to Ruby code.

An end-of-input condition is signaled by the user by entering Ctrl-z (in
windows) or Alt-z (in Linux/Mac). See the mini_readline gem (link above) for
more information on the keyboard mappings used by mysh.

### Handlebars

In mysh, it is possible to embed snippets of ruby into text files, in shell
variables or on the command line through the use of handlebars. Handlebars
look like this:

    {{ code goes here  }}

Lets see a simple example of putting the result of a calculation into the
command line:

    mysh>echo {{ (1..10).map {|i| i.to_s}.join(" ") }}  > foo.txt
    mysh>type foo.txt
    1 2 3 4 5 6 7 8 9 10

Handlebars work by evaluating the ruby code within the {{  }} sequence in
the appropriate execution environment. For the command line, this is the same
environment used for the '=' quick execution command. For example:

    mysh>=a="A very long string indeed!"
    "A very long string indeed!"
    mysh>echo {{ a }}
    A very long string indeed!

The value returned by expression is coverted to a string (if needed) and then
inserted in place of the handlebar expression. There are, however, times when
it is not desired to insert anything in the place of the code snippet. For
those cases, simply end the expression with a '#' character. For example:

    mysh>echo {{ "not embedded" #}}{{ "embedded" }}
    embedded

Finally, it may be that it is desired to embed braces into a text file or
the command line. In that case precede the brace with a backslash character
like: \\{  or \\}

### Command History

The history (or !) command is used to allow the user greater control over the
history of commands that have been entered. The action taken by the history
command is controlled by an optional parameter.

If the longer form, show is used, a space is required before the parameter. If
the quick form, ! is used, the space is optional.

Quick&nbsp;Form | Long Form    |  Command Description
-----------|--------------|--------------------------------
!          | history      | Display the entire history buffer.
!5         | history 5    | Retrieve history entry 5 and present this to the user as the next command.
!clear     | history clear| Clear the command history.
!pattern   | history&nbsp;pattern | Display the part history buffer containing the specified regular expression pattern. Note: The pattern cannot be the word "clear", use "clea[r]" instead.

### Shell Variables

In mysh, variables are kept that control the behavior of the shell. This simple
command is used to set, delete, and display these variables. The basic method
for setting a variable is:

    set $name=value

Where:
* name is a word matching the regex: /[a-z][a-z0-9_]*/. Note: lower case only.
* value is some text, with optional embedded variables and handlebars.

To erase the value of a variable, use:

    set $name=

To display the name/value of a variable, use:

    set $name

To display all variable names/values use just enter "set". As an escapement,
the string $$ maps to a single $. Some variables that are used in mysh are:

Variable    | Description
------------|--------------------------------------------
$d          | The current date.
$date_fmt   | The format for the date: "%Y-%m-%d"
$debug      | Does the shell display additional debugging info (true/false)
$h          | The home folder's path
$history    | Is command line history enabled?
$name       | The name given to this mysh session.
$no_move    | Entries are not moved up when pulled from the command history.
$page_height| The page height.
$page_msg   | The paging message. Default is "Press a key, a space, or q:"
$page_pause | Is page pausing enabled?
$page_width | The page width.
$post_prompt| The prompt used when a line is continued with a trailing \\ character. By default this is the same as the normal prompt.
$pre_prompt | A prompt string displayed before the actual command prompt. Delete the pre_prompt variable to disable pre-prompting.
$prompt     | The user prompt.
$r          | The location of the Ruby compiler.
$s          | The location of the host command interpreter.
$t          | The current time.
$time_fmt   | The format for the time: "%H:%M"
$type       | Does the type command operate in cooked or raw mode. Default is raw mode.
$u          | The current user.
$w          | The current working directory's path.

#### Some Examples:

Imagine you wish to have all commands numbered sequentially. Use this or put it
in the Mysh ini file.

    set $prompt = {{ cmd_cter||=0; cmd_cter+=1 }} mysh>

And the command line will look like:

    1 mysh>ls
    CODE_OF_CONDUCT.md  LICENSE.txt  lib           rakefile.rb  tests
    Gemfile             README.md    mysh.gemspec  reek.txt
    Gemfile.lock        bin          pkg           samples
    C:\Sites\mysh
    2 mysh>git status
    On branch master
    Your branch is up to date with 'origin/master'.

    nothing to commit, working tree clean
    C:\Sites\mysh
    3 mysh>

### Ruby Expressions:

In mysh, ruby code may be executed at any time from command prompt. This allows
the mysh command line to serve as a programming, debugging and super-calculator
environment. Just a few reminders:

* Any line beginning with an equals "=" sign will be evaluated as a Ruby
  expression.
* Expressions ending with a backslash character "\\" are continued on the next
  line. The prompt changes to end with a "\\" character to indicate that this
  is going on.
* The results of the expression are displayed using the pretty-print facility.
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

### Shell Help

The help (or ?) command is used to get either general help about mysh or an
optional specified topic. If the longer form, help is used, a space is required
before the topic. If the quick form, ? is used, the space is optional. Of note
is the command "help help" or "??" which provides a list of all available help
topics. These are:

Topic      | Description
-----------|----------------------------------------------------
none       | General help on mysh.
!          | Help on the history command.
%          | Help on timed command execution.
=          | Help on ruby expressions.
?          | This help on the help command.
@          | Help on the show command.
env        | Help on the show env command.
gem        | Help on the show gem command.
gls        | Help on the gls command.
help       | This help on the help command.
history    | Help on the history command.
init       | Help on mysh initialization.
kbd        | Help on mysh keyboard mapping.
math       | Help on math functions.
mls        | Help on the mls command.
quick      | Help on quick commands.
ruby       | Help on the show ruby command.
set        | Help on mysh variables.
show       | Help on the show command.
term       | Help on the show term command.
type       | Help on the type command.
types      | Help on mysh file types.
usage      | Help on mysh usage options.
{{         | Help on mysh handlebars.

Also, absent any detailed help information, the help command will show the
summary of any internal command.

### Shell Info

The show (or @) command is used to inspect various aspects of the mysh
environment specified by the item parameter. If the longer form, show is used,
a space is required before the topic. If the quick form, @ is used, the space
is optional. Currently, mysh supports two areas on inquiry: the environment and
ruby:

##### Environment (@env)

This command displays useful information about the current operating
environment.

Topic    | Description
---------|----------------------------------------------------
about    | A brief description of the mysh shell program.
version  | The version of mysh in use.
installed| All installed versions of mysh.
latest   | The latest version of mysh.
init file| The init file in use or &#60;none found&#62; or &#60;none&#62;.
user     | The current user name.
home     | The current home directory.
name     | The path/name of the mysh program currently executing.
os shell | The path/name of the system command shell.
host     | The name of the host computer.
os       | The current operating system.
platform | The operating platform detected by the low-level terminal gem.
java     | Is the current platform powered by Java?
PID      | The process ID of the mysh program.
path     | An easy-to-read, formatted version of the current search path.


##### Ruby (@ruby)

This command displays useful information about the currently running ruby
language system.

Topic       | Description
------------|----------------------------------------------------
location    | The path/name of the current ruby interpreter.
description | A comprehensive summary of the version and other such data.
version     | The version of ruby.
patch       | Its patch level.
revision    | Its revision level.
date        | The date of its release.
platform    | The target platform.
copyright   | The legal ownership of the software.
engine      | The internal engine in the software.
host        | A summary of the host operating environment.
host cpu    | A (crude) approximation of the installed cpu.
host os     | The current operating system.
host vendor | The current environment vendor/genre.
$:          | An easy-to-read, formatted version of $: or the ruby search path.

##### Gem (@gem)

The show gem (or @gem) command is used to display useful information about
the current gem system. There are two distinct ways to use this command.

The first is without any arguments. This displays general information about the
gem subsystem. This includes:

Topic         | Description
--------------|----------------------------------------------------
about         | About rubygems.
version       | The current version of rubygems.
latest        | The latest version of rubygems available.
marshal       | The version of the marshal format for your Ruby.
host          | Get the default RubyGems API host. This is normally https://rubygems.org.
sources       | Returns an Array of sources to fetch remote gems from.
gem folder    | The path where gems are to be installed.
bin folder    | The path where gem executables are to be installed.
config path   | The path to standard location of the user's .gemrc file.
cert path     | The default signing certificate chain path
key path      | The default signing key path
spec cache    | The path to where specs are cached.
file suffixes | Suffixes for require-able paths.
gem dep files | The files where dependencies may be specified. Use Gemfile
gem platforms | Array of platforms this RubyGems supports.
gem path      | The folders searched when looking for a gem locally.

The alternative is to specify a list of gems of interest. For each gem in the
list, the program will list all installed versions of that gem and the latest
version of that gem on the rubygems host. For example:

    8 mysh>@gem rails gosu
    Info on specified gems.

    rails  4.2.0, 5.1.3, 5.1.6
    latest 5.2.2

    gosu   0.13.3
    latest 0.14.4

##### Term (@term)

This command displays useful information about the console.

Topic         | Description
--------------|----------------------------------------------------
about         | About the mini_readline gem.
version       | The installed version of mini_readline.
installed     | All installed versions of mini_readline.
latest        | The latest version of mini_readline available.
about         | About the mini_term gem.
version       | The installed version of mini_term.
installed     | All installed versions of mini_term.
latest        | The latest version of mini_term available.
platform      | The operating platform detected by mini_term.
columns       | The number of columns in the console.
rows          | The number of rows in the console.
code page     | For Windows, what is the current code page?
term          | What terminal is defined by the system, if one is defined.
disp          | What display is defined by the system, if one is defined.
edit          | What editor is defined by the system, if one is defined.


### Internal Shell Commands:

Internal commands are recognized by name and are executed by mysh directly. The
complete list of internal commands is given in the default help command ("?").
Some commands, not already covered in other sections include:

Command          | Description
-----------------|----------------------------------------------------
cancel           | Cancel the current mysh execution level.
cd <dir>         | Change directory to the optional <dir> parameter or display the current working directory.
exit             | Exit out of the mysh.
gls <-l> <mask>  | Display the loaded ruby gems.
help <topic>     | Display help information for mysh with an optional topic.
history <arg>    | Display the mysh command history.
load <file>      | Load a ruby program, mysh script, or text file into the mysh
mls <mask>       | Display modules with version info.
pwd              | Display the current working directory.
say <stuff>      | Display the text in the command arguments.
set <$name>=value| Set/query mysh variables.
show <item>      | Display information about a part of mysh.
type <file>      | Display one or more text files with optional support for embedded handlebars and shell variables.

Notes:
1. The notation {x} means that x is optional.
2. The load command applied to a mysh script file acts exactly the same
   as if the script file were executed directly from the command line. As a
   result of this:

```
myfile.mysh
load myfile.mysh
```
do the same thing. In addition:
```
myfile.txt
load myfile.txt
type myfile.txt
```
are also all equivalent. It is however noteworthy that these two are *not*
equivalent!
```
myfile.rb
load myfile.rb
```
The first executes myfile.rb with a new instance of the ruby interpreter. The
second loads myfile.rb into the current mysh ruby environment. See below for
more info.

### External Mysh Commands

These commands are recognized by having the first word in the input have a
recognized extension. These are:

Extension      | Description
---------------|----------------------------------------------------
.rb            | A ruby source file executed via a new instance of the compiler.
.mysh          | A mysh script file. Commands in this file are executed as if the user typed them in at the console.
.txt           | A text file. The file (with any embedded code and variables) is displayed on the console.

Here is a sample session with an external Ruby program.

```
mysh>$debug = on
mysh>samples/test.rb 1 2 $d $t
=> samples/test.rb 1 2 2016-12-21 13:43
=> C:/RailsInstaller/Ruby2.1.0/bin/ruby.exe samples/test.rb 1 2 2016-12-21 13:43
Running sample file.
args = ["1", "2", "2016-12-21", "13:43"]
mysh>
```

### External Commands:

All other commands are executed by the system using the standard shell or
the appropriate ruby interpreter. In effect, the system method is the action of
last resort for mysh commands.

Notes:
* If an internal command has the same name as an external command, adding a
  leading space will force the use of the external command.

## Embedding mysh in an application.

The mysh can also be used from within a Ruby application:

```ruby
require "mysh"

#Some application stuff omitted.

Mysh.run
```

The run command takes an optional array of command line style options similar
in nature to the ARGV ruby constant. If omitted, mysh is run with no optional
parameters. These parameters are documented in the Usage section above.

#### Adding New Commands

It is possible to add new internal commands to the mysh CLI. This may done
manually by depositing the appropriate ruby file in the actions folder
located at:

    <gem_root>/mysh/lib/mysh/internal/actions

A survey of the contents of that folder will reveal the nature of these files.

New internal commands may also be added in code via the the add_action method
of the Action class of the Mysh module. There are two ways to do this:

* The command may be created as an instance of the Action class with a command
name, description and a block that contains the action to be performed by this
command. This block takes one parameter, an input wrapper (see About Command
Arguments below for details). This approach is best when the command is simple
enough to fit into a single lambda block of code. Like this template:

```ruby
module Mysh
  command_name = 'new <item>'
  desc = "A succinct description of what this command does."
  action = lambda do |input|
    #Action packed stuff goes here!
  end

  COMMANDS.add_action(Action.new(command_name, desc, &action))
end
```


* The command may be created as an instance of a sub-class of the Action class.
In this case, only a name and description are needed as the sub-class should
contain all the needed code. The action method is the process_command and this
takes one parameter, an input wrapper (see About Command Arguments below for
details). This approach is required when the command action needs to be spread
across multiple methods. Like this template:

```ruby
module Mysh
  class NewCommand < Action
    #This method is called when the command is executed.
    def process_command(input)
      #Even more action packed stuff goes here!
    end
  end

  desc = "A succinct description of what this command does."
  command_name = 'new <item>'
  COMMANDS.add_action(NewCommand.new(command_name, desc))
end
```

##### Command names:
The name of the command is a string with optional argument descriptions
separated with spaces. The command is the first word of this string. For
example a command_name of:

```
"new <item>"
```

will create a command called "new" with a title of "new &#60;item&#62;"

##### Command descriptions:
A string or an array of strings that describe the command. This serves as the
descriptive help for the command. The help display code handles matters like
word wrap automatically.

##### About Command Arguments

The process_command method take one parameter that is an instance of the
InputWrapper class. This class provides several ways to access the parts of the
command line. These are:

Method        | Description
--------------|----------------
raw           | The raw, unprocessed command line text.
cooked        | The command line with variables and handlebars expanded.
raw_command   | The command portion of the raw text.
quick_command | The quick command of the raw text.
raw_body      | The raw text after the command.
quick_body    | The raw text after the quick command.
cooked_body   | The cooked text after the command.
parsed        | The command and parameters parsed into an array of strings.
args          | The parameters parsed into an array of strings.

Note: commands are not normally "cooked". Should this be required
use the following code snippet:

```ruby
input.raw.preprocess
```

##### Some Useful Helper Methods

Within the mysh environment, there exists a number of methods designed to make
life easier in adding new commands or in load ruby files or embedded into
handlebars. Some of these more noteworthy methods are listed below:

###### MNV[:name]
Retrieve the mysh variable "$name"

###### MNV[:name]="value"
Set/Update the mysh variable "$name". Note that the value is always a string,
even for things like "true" and "false". If the value is an empty string, the
variable is deleted.

###### mysh "string"
Execute the string as a mysh command.

###### Mysh.parse_args("string")
Parse the string into an array of arguments.

###### Mysh.input.readline(parms)
Get a line of input from the console. See the mini_readline gem for info
on the optional parms.

###### "string".preprocess(context=mysh_default_context)
Process the string for embedded variables and handlebars. By default,
any embedded ruby  is evaluated in the mysh global expression binding. However,
another binding may be passed to access an alternative execution environment.

###### "string".to_host_spec
Given a string with a file spec, to_host_spec adjusts that string so that it is
more pleasing to the local environment. This is a great boon to writing
effortless portable code.

###### "string".to_std_spec
Given a string with a file spec, to_std_spec adjusts that string so that it is
compatible with standard usage. This is a great boon to writing effortless
portable code.


#### Adding Help Topics

In mysh, help topics are generally implemented as text files often augmented
with embedded mysh variables and ruby code. It it noteworthy however that they
can also be mysh script or ruby code files. The management of these help files
is located in the file:
```
mysh/lib/mysh/internal/actions/help/sub_help.rb
```
In this file, you can locate a variable called "help". This is an array of
arrays where each line describes a help topic. Within each line is a further
array of three strings. Respectively these are:
1. The name of the help item.
2. A brief description of the help topic. This line is used in the help on help
(??) topic.
3. The name of the file, **with its extension**, that contains the actual help
information.

To add a new help topic, simply add the new help file to the help folder and
and a corresponding line entry to to the help variable.

#### Exceptions:

As an application, exception handling is largely an internal matter. However,
since user code can be embedded in mysh, they should be documented. The mysh
application gem uses the following exception classes:

    Exception              # From Ruby.
      StandardError        # From Ruby.
        MyshException      # The abstract base exception for mysh.
          MyshExit         # Exit the current mysh processing loop.
          MyshUsage        # Internal: Used by the --help options.


## Contributing

All participation is welcomed. There are two fabulous plans to choose from:

#### Plan A

1. Fork it (https://github.com/PeterCamilleri/mysh/fork)
2. Switch to the development branch ('git branch development')
3. Create your feature branch ('git checkout -b my-new-feature')
4. Commit your changes ('git commit -am "Add some feature"')
5. Push to the branch ('git push origin my-new-feature')
6. Create new Pull Request

#### Plan B

Go to the GitHub repository at (https://github.com/PeterCamilleri/mysh) and
raise an [issue](https://github.com/PeterCamilleri/mysh/issues)
calling attention to some aspect that could use some TLC or a suggestion or an
idea or a comment.

This is a low pressure environment. All are welcome!
