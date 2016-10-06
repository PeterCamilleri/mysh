# coding: utf-8

#* user_input/handlebars.rb -- Handlebar embedded ruby support.
class Object

  #Process a string with embedded Ruby code.
  #<br>Endemic Code Smells
  #* :reek:TooManyStatements
  def eval_handlebars(in_str)
    out_str = ""

    loop do
      pre_match, match, in_str = in_str.partition(/{{.*?}}/m)

      out_str << pre_match

      return out_str.gsub(/\\\S/) {|found| found[1]} if match.empty?

      code   = match[2...-2]
      silent = code.end_with?("#")
      result = instance_eval(code)
      out_str << result.to_s unless silent
    end
  end

  #Expand a file with embedded ruby handlebars.
  def eval_handlebar_file(name)
    eval_handlebars(IO.read(name))
  end

  #Show a file with embedded ruby handlebars.
  def show_handlebar_file(name)
    puts eval_handlebar_file(name)
  rescue Interrupt, StandardError, ScriptError => err
    puts "Error in file: #{name}\n#{err.class}: #{err}"
  end

end


