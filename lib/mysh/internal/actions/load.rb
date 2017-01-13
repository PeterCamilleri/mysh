# coding: utf-8

#* mysh/internal/actions/load.rb -- The mysh load command.
module Mysh

  #* mysh/internal/actions/load.rb -- The mysh load command.
  class LoadCommand < Action

    #Execute the load command.
    def call(args)
      file_name = args.shift

      if !file_name
        puts "Error: A file must be specified."
      elsif File.extname(file_name) == '.mysh'
        Mysh.process_file(file_name)
      else
        load file_name
      end
    end

  end

  #Add the load command to the library.
  desc = 'Load a ruby program or mysh script file into the mysh environment.'
  COMMANDS.add_action(LoadCommand.new('load file', desc))
end
