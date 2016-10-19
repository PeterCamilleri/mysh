# coding: utf-8

#* internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #Try to execute the string as a quick command.
  def self.try_execute_quick_command(str)
    case str[0]
    when '='
      @exec_host.execute(str)
      :expression

    when '?'
      HELP_COMMAND.call(parse_args(str[1...-1]))
      :internal

    when '@'

    else
      false
    end
  end


end

