# coding: utf-8

# mysh -- MY SHell -- a Ruby/Rails inspired command shell.

#Use the mini_readline gem but make sure that it does
#not interfere with the standard readline library.
$no_alias_read_line_module = true
require "mini_readline"

require_relative "mysh/version"

#The MY SHell module. A container for its functionality.
module Mysh

  #The MyShell class that implements the shell.
  class MyShell

    #Set up the shell instance.
    def initialize
      @input = MiniReadline::Readline.new(history: true, eoi_detect: true)
    end

    #The actual shell method.
    def do_mysh
      loop do
        input = @input.readline
        system(input)
      end

      rescue MiniReadlineEOI
    end
  end
end

if __FILE__ == $0
  Mysh::MyShell.new.do_mysh
end
