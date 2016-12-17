# coding: utf-8

require_relative 'handlebars/string'

#* user_input/handlebars.rb -- Handlebar embedded ruby support.
class Object

  #Show a file with embedded ruby handlebars.
  #<br>Note:
  #The message receiver is the evaluation host for the handlebar code.
  def show_handlebar_file(name, evaluator=$mysh_exec_host)
    puts eval_handlebar_file(name, evaluator)
  rescue Interrupt, StandardError, ScriptError => err
    puts "Error in file: #{name}\n#{err.class}: #{err}"
    puts err.backtrace if MNV[:debug]
  end

  #Expand a file with embedded ruby handlebars.
  #<br>Note:
  #The message receiver is the evaluation host for the handlebar code.
  #<br>Endemic Code Smells
  #* :reek:UtilityFunction
  def eval_handlebar_file(name, evaluator)
    IO.read(name).eval_variables.eval_handlebars(evaluator).eval_quoted_braces
  end

end


