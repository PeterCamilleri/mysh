# coding: utf-8

#* mysh/external_ruby.rb -- Support for executing Ruby files with the ruby interpreter.
module Mysh

  #Try to execute as a Ruby program.
  def self.try_execute_external_ruby(str)

    if (cmd = str.split[0])
      ext = File.extname(cmd)

      if ext == '.rb'
        new_command = "#{RbConfig.ruby} #{str}"
        puts "=> #{new_command}"  if MNV[:debug]
        system(new_command)
        :ruby_exec
      elsif ext == '.mysh'
        Mysh.process_file(cmd)
        :mysh_script
      end
    end
  end

end
