# coding: utf-8

require_relative 'handlebars/string'

#* user_input/handlebars.rb -- Handlebar embedded ruby support.
class Object

  #Show a file with embedded ruby handlebars.
  #<br>Note:
  #The message receiver is the evaluation host for the handlebar code.
  def show_handlebar_file(name)
    puts eval_handlebar_file(name)
  rescue Interrupt, StandardError, ScriptError => err
    puts "Error in file: #{name}\n#{err.class}: #{err}"
    puts err.backtrace if MNV[:debug]
  end

  #Expand a file with embedded ruby handlebars.
  #<br>Note:
  #The message receiver is the evaluation host for the handlebar code.
  def eval_handlebar_file(name)
    IO.read(name)
      .eval_variables
      .eval_handlebars
      .eval_quoted_braces
  end

end


