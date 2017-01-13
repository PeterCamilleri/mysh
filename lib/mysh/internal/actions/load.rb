# coding: utf-8

#* mysh/internal/actions/load.rb -- The mysh load command.
module Mysh

  #* mysh/internal/actions/load.rb -- The mysh load command.
  class LoadCommand < Action

    #Execute the load command.
    def call(args)
      file_name = args.shift

      if file_name
        load file_name
      else
        puts "Error: A Ruby file must be specified."
      end
    end

  end

  #Add the load command to the library.
  desc = 'Load a ruby program into the mysh environment.'
  COMMANDS.add_action(LoadCommand.new('load', desc))
end
