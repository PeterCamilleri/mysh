# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #A hash of quick command short cuts and their actions.
  default = Action.new do |args|
    false
  end

  QUICK = ActionPool.new("", default)

  QUICK['!'] = lambda {|str| HISTORY_COMMAND.process_quick_command(str) }
  QUICK['#'] = lambda {|str| MYSH_COMMENT.process_command(str) }
  QUICK['$'] = lambda {|str| VARS_COMMAND.process_command(str) }
  QUICK['%'] = lambda {|str| TIMED_COMMAND.process_command(str) }
  QUICK['='] = lambda {|str| $mysh_exec_host.execute(str) }
  QUICK['?'] = lambda {|str| HELP_COMMAND.process_quick_command(str) }
  QUICK['@'] = lambda {|str| SHOW_COMMAND.process_quick_command(str) }

  #Try to execute the string as a quick command.
  def self.try_execute_quick_command(str)
    QUICK[str[0]].process_command(str)
  end

end

