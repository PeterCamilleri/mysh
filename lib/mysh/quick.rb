# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #A hash of quick command short cuts and their actions.
  QUICK = Hash.new(lambda {|_str| false})

  QUICK['!'] = lambda {|str| HISTORY_COMMAND.process_quick_command(str) }
  QUICK['#'] = lambda {|str| MYSH_COMMENT.call(str) }
  QUICK['$'] = lambda {|str| VARS_COMMAND.call(str) }
  QUICK['%'] = lambda {|str| TIMED_COMMAND.call(str) }
  QUICK['='] = lambda {|str| $mysh_exec_host.execute(str) }
  QUICK['?'] = lambda {|str| HELP_COMMAND.process_quick_command(str) }
  QUICK['@'] = lambda {|str| SHOW_COMMAND.process_quick_command(str) }

  #Try to execute the string as a quick command.
  def self.try_execute_quick_command(str)
    QUICK[str[0]].call(str)
  end

end

