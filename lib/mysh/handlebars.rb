# coding: utf-8

require_relative 'handlebars/eval_handlebars'

# Handlebar embedded ruby support.
class Object

private

  # Show a file with embedded ruby handlebars.
  # Note: The message receiver is the evaluation host for the handlebar code.
  def show_handlebar_file(name, evaluator = $mysh_exec_binding)
    puts eval_handlebar_file(name, evaluator)
  end

  # Expand a file with embedded ruby handlebars.
  # Note: The message receiver is the evaluation host for the handlebar code.
  # Endemic Code Smells   :reek:UtilityFunction
  def eval_handlebar_file(name, evaluator)
    IO.read(name).preprocess(evaluator)
  end

end
