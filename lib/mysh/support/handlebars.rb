# coding: utf-8

#* support/handlebars.rb -- Handlebar embedded ruby support.
class Object

  #Process a string with embedded Ruby code.
  def eval_handlebars(str)
    loop do
      pre_match, match, post_match = str.partition(/{{.*?}}/m)

      return pre_match if match.empty?

      str = pre_match + instance_eval(match[2...-2]) + post_match
    end
  end

  #Expand a file with embedded ruby handlebars.
  def eval_handlebar_file(name)
    eval_handlebars(IO.read(name))
  end

  #Show a file with embedded ruby handlebars.
  def show_handlebar_file(name)
    puts eval_handlebar_file(name)
  rescue StandardError, ScriptError => err
    puts "Error in file: #{name}\n#{err.class}: #{err}"
  end

end


