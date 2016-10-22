# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #Try to execute the string as a quick command.
  #<br>Endemic Code Smells
  #* :reek:TooManyStatements
  def self.try_execute_quick_command(str)
    arg_str = str[1...-1]

    case str[0]
    when '!'
      HISTORY_COMMAND.parse_and_call(arg_str)

    when '='
      @exec_host.execute(str)
      :expression

    when '?'
      HELP_COMMAND.parse_and_call(arg_str)

    when '@'
      SHOW_COMMAND.parse_and_call(arg_str)

    else
      false
    end
  end


end

