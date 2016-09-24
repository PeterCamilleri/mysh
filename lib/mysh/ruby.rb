# coding: utf-8

#* ruby.rb -- Support for executing Ruby files with the ruby interpreter.
module Mysh

  #Try to execute as a Ruby program.
  def self.ruby_execute(str)
    if File.extname(str.split[0]) == '.rb'
      new_command = "ruby #{str}"

      puts "=> #{new_command}"
      puts

      system(new_command)
      :ruby_exec
    end

  end

end
