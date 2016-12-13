# coding: utf-8

# mysh -- MY SHell -- a Ruby/Rails inspired command line shell.

require 'English'
require 'in_array'

require_relative 'mysh/user_input'
require_relative 'mysh/quick'
require_relative 'mysh/expression'
require_relative 'mysh/internal'
require_relative 'mysh/external_ruby'
require_relative 'mysh/shell_variables'
require_relative 'mysh/version'

#The Mysh (MY SHell) module. A container for mysh and its functionality.
module Mysh

  #The actual shell method.
  def self.run
    setup

    while @mysh_running do
      execute_a_command(get_command("mysh"))
    end
  end

  #Common initialization tasks.
  def self.setup
    reset_host
    init_input
    @mysh_running = true
  end

  #Execute a single line of input.
  def self.execute_a_command(str)
    try_execute_command($mysh_exec_host.eval_handlebars(str))

  rescue MiniReadlineEOI
    @mysh_running = false

  rescue Interrupt, StandardError, ScriptError => err
    puts err, err.backtrace
  end

  #Try to execute a single line of input.
  def self.try_execute_command(input)
    try_execute_quick_command(input)    ||
    try_execute_internal_command(input) ||
    try_execute_external_ruby(input)    ||
    system(input)
  end

end

if __FILE__ == $0
  Mysh.run  #Run a shell if this file is run directly.
end
