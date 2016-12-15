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

  #Execute a single line of input and handle exceptions.
  def self.execute_a_command(str)
    try_execute_command(str)

  rescue MiniReadlineEOI
    @mysh_running = false

  rescue Interrupt, StandardError, ScriptError => err
    puts err
    puts err.backtrace if MNV[:debug]
  end

  #Try to execute a single line of input. Does not handle exceptions.
  def self.try_execute_command(input)
    unless input.start_with?("$")
      input = input.gsub(Value::PARSE) do |str|
                sym = str[1..-1].to_sym
                MNV.key?(sym) ? MNV[sym].to_s : "?#{str}?"
              end

      input = $mysh_exec_host.eval_handlebars(input)
    end

    puts "=> #{input}" if MNV[:debug]

    try_execute_quick_command(input)    ||
    try_execute_internal_command(input) ||
    try_execute_external_ruby(input)    ||
    system(input)
  end

end

if __FILE__ == $0
  Mysh.run  #Run a shell if this file is run directly.
end
