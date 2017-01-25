# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #A hash of quick command short cuts and their actions.
  QUICK = ActionPool.new("QUICK", Action.new {|_str| false })

  QUICK['!'] = Action.new {|str| HISTORY_COMMAND.process_quick_command(str) }
  QUICK['#'] = Action.new {|str| MYSH_COMMENT.process_command(str) }
  QUICK['$'] = Action.new {|str| VARS_COMMAND.process_command(str) }
  QUICK['%'] = Action.new {|str| TIMED_COMMAND.process_command(str) }
  QUICK['='] = Action.new {|str| $mysh_exec_host.execute(str) }
  QUICK['?'] = Action.new {|str| HELP_COMMAND.process_quick_command(str) }
  QUICK['@'] = Action.new {|str| SHOW_COMMAND.process_quick_command(str) }

  #Try to execute the string as a quick command.
  def self.try_execute_quick_command(str)
    QUICK[str[0]].process_command(str)
  end

end

