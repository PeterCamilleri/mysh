# coding: utf-8

#* ruby.rb -- Support for executing Ruby files with the ruby interpreter.
module Mysh

  #Try to execute as a Ruby program.
  def self.ruby_execute(str)
    if (command = str.split[0]) && File.extname(command) == '.rb'
      puts "=> #{new_command = "ruby #{str}"}\n\n"
      system(new_command)
      :ruby_exec
    end

  end

end
