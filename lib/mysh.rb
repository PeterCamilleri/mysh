# coding: utf-8

# mysh -- MY SHell -- a Ruby/Rails inspired command shell.

require 'English'

#Use the mini_readline gem but make sure that it does
#not interfere with the standard readline library.
$no_alias_read_line_module = true
require 'mini_readline'
require 'vls'

require_relative 'mysh/smart_source'
require_relative 'mysh/expression'
require_relative 'mysh/internal'
require_relative 'mysh/ruby'
require_relative 'mysh/version'

#The MY SHell module. A container for its functionality.
module Mysh

  class << self
    #The input text source.
    attr_reader :input
  end

  #The actual shell method.
  #<br>Endemic Code Smells
  #* :reek:TooManyStatements
  def self.run
    init_run

    loop do
      input = @input.readline(prompt: 'mysh> ')

      begin
        @exec_host.execute(input)      ||
        InternalCommand.execute(input) ||
        ruby_execute(input)            ||
        system(input)
      rescue Interrupt => err
        puts err
      end
    end

    rescue Interrupt, MiniReadlineEOI
  end

  #Set up for the run command.
  def self.init_run
    reset_host
    @input = MiniReadline::Readline.new(history: true,
                                        eoi_detect: true,
                                        auto_complete: true,
                                        auto_source: SmartSource)
  end

  #Reset the state of the execution hosting environment.
  def self.reset_host
    @exec_host = ExecHost.new
  end

end

#Some test code to run a shell if this file is run directly.
if __FILE__ == $0
  Mysh.run
end
