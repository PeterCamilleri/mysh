# coding: utf-8

#* internal/actions/type.rb -- The mysh type command.
module Mysh

  #* internal/actions/type.rb -- The mysh type command.
  class TypeCommand < Action

    #Execute the type command.
    def call(args)
      file_name = args.shift

      @exec_binding = binding

      if file_name
        show_handlebar_file(file_name)
      else
        puts "Error: A text file must be specified."
      end
    end

  end

  #Add the type command to the library.
  desc = 'Display a text file with optional embedded handlebars.'
  COMMANDS.add_action(TypeCommand.new('type', desc))
end
