# coding: utf-8

# mysh -- MY SHell -- a Ruby/Rails inspired command shell.

#Use the mini_readline gem but make sure that it does
#not interfere with the standard readline library.
$no_alias_read_line_module = true
require "mini_readline"

require_relative "mysh/version"

#The MY SHell class. Contains it's state.
class Mysh

end
