# coding: utf-8

#* mysh/external_ruby.rb -- Support for executing Ruby files with the ruby interpreter.
module Mysh

  #Try to execute as a Ruby program.
  #<br>Endemic Code Smells
  #* :reek:TooManyStatements
  def self.try_execute_external_ruby(str)
    args = parse_args(str.chomp)
    file_name = args.shift

    if (file_name)
      ext = File.extname(file_name)

      if ext == '.rb'
        new_command = "#{RbConfig.ruby} #{str}"
        puts "=> #{new_command}"  if MNV[:debug]
        system(new_command)
        :ruby_exec
      elsif ext == '.mysh'
        Mysh.process_file(file_name)
        :mysh_script
      elsif ext == '.txt'
        show_handlebar_file(file_name, BindingWrapper.new(binding))
        :internal
      end
    end
  end

end
