# coding: utf-8

#* mysh/internal/actions/type.rb -- The mysh type command.
module Mysh

  #* mysh/internal/actions/type.rb -- The mysh type command.
  class TypeCommand < Action

    #Execute the type command.
    def call(args)
      file_name = args.shift

      @exec_binding = binding

      if file_name
        show_handlebar_file(file_name, self)
      else
        puts "Error: A text file must be specified."
      end
    end

  end

  #Add the type command to the library.
  desc = 'Display a text file with support for optional embedded ' +
         'handlebars and mysh variables.'
  COMMANDS.add_action(TypeCommand.new('type file', desc))
end
