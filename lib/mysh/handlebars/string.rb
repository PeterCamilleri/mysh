# coding: utf-8

#Monkey patches for Mysh handlebars
class String

  #Evaluate any variable substitutions in the input.
  def eval_handlebars(evaluator=$mysh_exec_binding)
    gsub(/{{.*?}}/m) do |match|
      code   = match[2...-2]
      silent = code.end_with?("#")
      result = evaluator.eval(code)

      (result unless silent).to_s
    end
  end

  #Process quoted brace characters
  def eval_quoted_braces
    gsub(/\\[\{\}]/) {|found| found[1]}
  end

end
