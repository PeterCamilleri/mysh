# coding: utf-8

#* internal/actions/show.rb -- The mysh show command.
module Mysh

  #* internal/actions/show.rb -- The mysh show command.
  class ShowCommand < Action

    #Execute the show command.
    def execute(args)
      file_name = args.shift

      @exec_binding = binding

      if file_name
        show_handlebar_file(file_name)
      else
        puts "Error: A text file must be specified."
      end
    end

  end

  #Add the show command to the library.
  desc = 'Display a text file with optional embedded handlebars.'
  COMMANDS.add_action(ShowCommand.new('show', desc))
end
