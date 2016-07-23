# coding: utf-8

# mysh -- MY SHell -- a Ruby/Rails inspired command shell.

#Use the mini_readline gem but make sure that it does
#not interfere with the standard readline library.
$no_alias_read_line_module = true
require "mini_readline"

require_relative "mysh/internal"
require_relative "mysh/expression"
require_relative "mysh/version"

#The MY SHell module. A container for its functionality.
module Mysh

  class << self
    #The input text source.
    attr_reader :input
  end

  #The actual shell method.
  def self.do_mysh
    reset
    @input = MiniReadline::Readline.new(history: true, eoi_detect: true)

    loop do
      input = @input.readline(prompt: "mysh> ")

      @exec_host.execute(input)      ||
      InternalCommand.execute(input) ||
      system(input)
    end

    rescue MiniReadlineEOI
  end

  def self.reset
    @exec_host = ExecHost.new
  end

end

#Some test code to run a shell if this file is run directly.
if __FILE__ == $0
  Mysh.do_mysh
end
