# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #A hash of quick command short cuts and their actions.
  QUICK = Hash.new(lambda {|_str| false})

  QUICK['!'] = lambda {|str| HISTORY_COMMAND.quick_parse_and_call(str) }
  QUICK['='] = lambda {|str| $mysh_exec_host.execute(str) }
  QUICK['?'] = lambda {|str| HELP_COMMAND.quick_parse_and_call(str) }
  QUICK['@'] = lambda {|str| SHOW_COMMAND.quick_parse_and_call(str) }
  QUICK['$'] = lambda {|str| Mysh.shell_variable_command(str) }

  #Try to execute the string as a quick command.
  def self.try_execute_quick_command(str)
    QUICK[str[0]].call(str)
  end

end

