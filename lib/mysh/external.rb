# coding: utf-8

#* mysh/external.rb -- Support for executing external files.
module Mysh

  #Try to execute an external file.
  #<br>Endemic Code Smells
  #* :reek:TooManyStatements
  def self.try_execute_external(input)
    args = input.parsed
    file_name = args.shift

    if (file_name)
      ext = File.extname(file_name)

      if ext == '.rb'
        new_command = "#{RbConfig.ruby} #{input.cooked}"
        puts "=> #{new_command}"  if MNV[:debug].extract_boolean
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
