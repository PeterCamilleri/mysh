# coding: utf-8

# Monkey patches for Mysh handlebars
class String

  # Evaluate any variable substitutions in the input.
  def eval_handlebars(evaluator=$mysh_exec_binding)
    string, text, buffer = self, "", []

    # Translate the string with embedded code into Ruby code.
    until string.empty?
      text, code, string = string.partition(/{{.*?}}/m)

      unless text.empty?
        text = text.gsub(/\\[{}]/) {|found| found[1]}
        buffer << "_m_<<#{text.inspect};"
      else
        buffer << "" if buffer.empty?
      end

      unless code.empty?
        if code[-3] == "#"
          buffer << "#{code[2...-3]};"
        else
          buffer << "_m_<<(#{code[2...-2]}).to_s;"
        end
      end
    end

    # Evaluate the result of the translation.
    if buffer.length > 1
      evaluator.eval("_m_ = '';" + buffer.join + "_m_")
    else
      text
    end
  end

end
