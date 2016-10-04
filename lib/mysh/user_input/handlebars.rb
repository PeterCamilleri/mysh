# coding: utf-8

#* user_input/handlebars.rb -- Handlebar embedded ruby support.
class Object

  #Process a string with embedded Ruby code.
  def eval_handlebars(str)
    loop do
      pre_match, match, post_match = str.partition(/{{.*?}}/m)

      return pre_match if match.empty?

      result = instance_eval(code = match[2...-2])

      str = pre_match + (result unless code.end_with?("#")).to_s + post_match
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


