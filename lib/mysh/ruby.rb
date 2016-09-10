# coding: utf-8

module Mysh

  #Try to execute as a Ruby program.
  def self.ruby_execute(str)
    if File.extname(str.chomp) == '.rb'
      new_command = "ruby #{str}"

      puts "=> #{new_command}"
      puts

      system(new_command)
      :ruby_exec
    end

  end

end