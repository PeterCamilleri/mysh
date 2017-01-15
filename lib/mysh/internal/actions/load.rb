# coding: utf-8

#* mysh/internal/actions/load.rb -- The mysh load command.
module Mysh

  #* mysh/internal/actions/load.rb -- The mysh load command.
  class LoadCommand < Action

    #Execute the load command.
    def call(args)
      file_name = args.shift

      if file_name
        file_ext, @exec_binding = File.extname(file_name), binding

        if file_ext == '.mysh'
          Mysh.process_file(file_name)
          :internal
        elsif file_ext == '.txt'
          show_handlebar_file(file_name, self)
          :internal
        elsif ["", ".rb"].include?(file_ext)
          load file_name
          :internal
        else
          fail "Error: Unknown file type: #{file_name.inspect}"
        end

      else
        fail "Error: A load file must be specified."
      end

    end

  end

  #Add the load command to the library.
  desc = 'Load a ruby program, mysh script, or text file into the mysh environment.'
  COMMANDS.add_action(LoadCommand.new('load file', desc))
end
