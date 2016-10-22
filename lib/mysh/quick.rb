# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #A hash of quick command short cuts and their actions.
  QUICK = Hash.new(lambda {|_str| false})

  QUICK['!'] = lambda {|str| HISTORY_COMMAND.quick_parse_and_call(str) }
  QUICK['='] = lambda {|str| @exec_host.execute(str); :expression }
  QUICK['?'] = lambda {|str| HELP_COMMAND.quick_parse_and_call(str) }
  QUICK['@'] = lambda {|str| SHOW_COMMAND.quick_parse_and_call(str) }

  #Try to execute the string as a quick command.
  #<br>Endemic Code Smells
  #* :re ek:TooManyStatements
  def self.try_execute_quick_command(str)
    QUICK[str[0]].call(str)
  end

end

