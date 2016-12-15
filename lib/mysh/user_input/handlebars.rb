# coding: utf-8

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
    eval_handlebars(IO.read(name))
  end

  #Process a string with backslash quotes and code embedded in handlebars.
  #<br>Note:
  #The message receiver is the evaluation host for the handlebar code.
  def eval_handlebars(str)
    do_process_handlebars(str).gsub(/\\[\{\}]/) {|found| found[1]}
  end

  private

  #Process a string with code embedded in handlebars.
  #<br>Note:
  #The message receiver is the evaluation host for the handlebar code.
  def do_process_handlebars(str)
    str.gsub(/{{.*?}}/m) do |match|
      code   = match[2...-2]
      silent = code.end_with?("#")
      result = mysh_eval(code)

      (result unless silent).to_s
    end
  end

end


