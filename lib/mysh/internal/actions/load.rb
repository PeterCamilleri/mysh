# coding: utf-8

#* mysh/internal/actions/load.rb -- The mysh load command.
module Mysh

  #Add the load command to the library.
  desc = "Load a ruby program, mysh script, " +
         "or text file into the mysh environment."

  action = lambda do |args|
    file_name = args.shift

    if file_name
      file_ext = File.extname(file_name)

      if file_ext == '.mysh'
        Mysh.process_file(file_name)
        :internal
      elsif file_ext == '.txt'
        show_handlebar_file(file_name, BindingWrapper.new(binding))
        :internal
      elsif file_ext == '.rb'
        load file_name
        :internal
      else
        fail "Error: Unknown file type: #{file_name.inspect}"
      end

    else
      fail "Error: A load file must be specified."
    end
  end

  COMMANDS.add_action(Action.new('load file', desc, &action))
end
