# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #Try to execute the string as a quick command.
  def self.try_execute_quick_command(str)
    case str[0]
    when '!'
      HISTORY_COMMAND.call(parse_args(str[1...-1]))
      :history

    when '='
      @exec_host.execute(str)
      :expression

    when '?'
      HELP_COMMAND.call(parse_args(str[1...-1]))
      :help

    when '@'
      SHOW_COMMAND.call(parse_args(str[1...-1]))
      :show

    else
      false
    end
  end


end

