# coding: utf-8

#* mysh/internal/quick.rb -- The mysh internal quick commands.
module Mysh

  #A hash of quick command short cuts and their actions.
  QUICK = Hash.new(lambda {|_input| false })

  QUICK['!'] = lambda {|input| HISTORY_COMMAND.process_quick_command(input)}
  QUICK['#'] = lambda {|input| MYSH_COMMENT.process_command(input)}
  QUICK['%'] = lambda {|input| TIMED_COMMAND.process_command(input)}
  QUICK['?'] = lambda {|input| HELP_COMMAND.process_quick_command(input)}
  QUICK['@'] = lambda {|input| SHOW_COMMAND.process_quick_command(input)}

  QUICK['='] = lambda do |input|
    pp $mysh_exec_binding.eval("$mysh_exec_result" + input.raw.preprocess)
    :expression
  end

  #Try to execute the inputing as a quick command.
  def self.try_execute_quick(input)
    QUICK[input.quick_command].call(input)
  end

end

