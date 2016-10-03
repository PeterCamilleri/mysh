# coding: utf-8

require_relative 'support/smart_source'

#* user_input.rb -- Get a command from the user.
module Mysh

  #Get one command from the user.
  def self.get_command
    input = @input.readline(prompt: 'mysh>')
    get_command_extra(input)
  end

  private

  #Get any continuations of the inputs
  def self.get_command_extra(str)
    if /\\\s*$/ =~ str
      parms = {prompt: 'mysh\\', prefix: str[0] }
      get_command_extra($PREMATCH + "\n" + @input.readline(parms))
    else
      str
    end

  end


end


