# coding: utf-8

#* internal/actions/show.rb -- The mysh show command.
module Mysh

  #* help.rb -- The mysh internal help command.
  class Action

    # The base help command.
    desc = 'Display a text file with optional embedded handlebars.'

    show = COMMANDS.add('show <file>', desc) do |args|
      file_name = args.shift

      @exec_binding = binding

      if file_name
        show_handlebar_file(file_name)
      else
        puts "Error: A text file must be specified."
      end
    end

  end

end

