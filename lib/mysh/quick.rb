# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #Try to execute the string as a quick command.
  #<br>Endemic Code Smells
  #* :reek:TooManyStatements
  def self.try_execute_quick_command(str)
    case str[0]
    when '!'
      HISTORY_COMMAND.quick_parse_and_call(str)

    when '='
      @exec_host.execute(str)
      :expression

    when '?'
      HELP_COMMAND.quick_parse_and_call(str)

    when '@'
      SHOW_COMMAND.quick_parse_and_call(str)

    else
      false
    end
  end


end

