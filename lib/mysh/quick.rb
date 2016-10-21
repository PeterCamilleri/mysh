# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #Try to execute the string as a quick command.
  #<br>Endemic Code Smells
  #* :reek:UtilityFunction :reek:FeatureEnvy :reek:TooManyStatements
  def self.try_execute_quick_command(str)
    target_args = parse_args(str[1...-1])

    case str[0]
    when '!'
      HISTORY_COMMAND.call(target_args)
      :history

    when '='
      @exec_host.execute(str)
      :expression

    when '?'
      HELP_COMMAND.call(target_args)
      :help

    when '@'
      SHOW_COMMAND.call(target_args)
      :show

    else
      false
    end
  end


end

