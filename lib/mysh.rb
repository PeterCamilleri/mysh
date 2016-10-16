# coding: utf-8

# mysh -- MY SHell -- a Ruby/Rails inspired command line shell.

require 'English'
require 'mini_readline'
require 'vls'
require 'in_array'

require_relative 'mysh/user_input'
require_relative 'mysh/expression'
require_relative 'mysh/internal'
require_relative 'mysh/external_ruby'
require_relative 'mysh/version'

#The MY SHell module. A container for its functionality.
module Mysh

  class << self
    #The input text source.
    attr_reader :input
  end

  #The actual shell method.
  def self.run
    setup

    while @mysh_running do
      execute_a_command
    end
  end

  #Common initialization tasks.
  def self.setup
    reset_host
    init_input
    @mysh_running = true
  end

  #Execute a single line of input.
  def self.execute_a_command
    try_execute_command(@exec_host.eval_handlebars(get_command))

  rescue MiniReadlineEOI
    @mysh_running = false

  rescue Interrupt, StandardError, ScriptError => err
    puts err, err.backtrace
  end

  #Try to execute a single line of input.
  def self.try_execute_command(input)
    try_execute_ruby_expression(input)  ||
    try_execute_internal_command(input) ||
    try_execute_external_ruby(input)    ||
    system(input)
  end

end

#Some test code to run a shell if this file is run directly.
if __FILE__ == $0
  Mysh.run
end
