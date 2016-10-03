# coding: utf-8

# mysh -- MY SHell -- a Ruby/Rails inspired command shell.

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
  #<br>Endemic Code Smells
  #* :reek:TooManyStatements
  def self.run
    reset_host
    init_input

    loop do
      input = get_command

      begin
        try_expression_execute(input) ||
        try_internal_execute(input)   ||
        try_external_ruby(input)      ||
        system(input)
      rescue Interrupt => err
        puts err, err.backtrace
      end
    end

    rescue MiniReadlineEOI
      nil

    rescue Interrupt, StandardError, ScriptError => err
      err
  end

end

#Some test code to run a shell if this file is run directly.
if __FILE__ == $0
  result = Mysh.run
  puts result, result.backtrace if result
end
