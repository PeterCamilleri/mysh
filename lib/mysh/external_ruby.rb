# coding: utf-8

#* external_ruby.rb -- Support for executing Ruby files with the ruby interpreter.
module Mysh

  #Try to execute as a Ruby program.
  def self.ruby_execute(str)
    cmd = str.split[0]

    if cmd && File.extname(cmd) == '.rb'
      new_command = "#{RbConfig.ruby} #{str}"
      puts "=> #{new_command}"
      system(new_command)
      :ruby_exec
    end

  end

end
