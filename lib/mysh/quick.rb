# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #A hash of quick command short cuts and their actions.
  QUICK = ActionPool.new("QUICK", Action.new {|_input| false })

  QUICK['!'] = Action.new {|input| HISTORY_COMMAND.process_quick_command(input)}
  QUICK['#'] = Action.new {|input| MYSH_COMMENT.process_command(input)}
  QUICK['$'] = Action.new {|input| VARS_COMMAND.process_command(input)}
  QUICK['%'] = Action.new {|input| TIMED_COMMAND.process_command(input)}
  QUICK['='] = Action.new {|input| $mysh_exec_host.execute(input)}
  QUICK['?'] = Action.new {|input| HELP_COMMAND.process_quick_command(input)}
  QUICK['@'] = Action.new {|input| SHOW_COMMAND.process_quick_command(input)}

  #Try to execute the inputing as a quick command.
  def self.try_execute_quick(input)
    QUICK[input.head].process_command(input)
  end

end

