# coding: utf-8

#* mysh/pre_processor.rb -- The mysh macro/handlebar preprocessor.
class String

  #The mysh string pre-processor stack.
  def preprocess(evaluator=$mysh_exec_binding)
    self.eval_variables.eval_handlebars(evaluator)
  end

end
