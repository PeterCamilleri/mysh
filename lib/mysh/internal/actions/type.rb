# coding: utf-8

#* mysh/internal/actions/type.rb -- The mysh type command.
module Mysh

  #Add the type command to the library.
  desc = 'Display a text file with support for optional embedded ' +
         'handlebars and mysh variables.'

  action = lambda do |args|
    file_name = args.shift

    if file_name
      show_handlebar_file(file_name, BindingWrapper.new(binding))
    else
      fail "A text file must be specified."
    end
  end

  COMMANDS.add_action(Action.new('type file', desc, &action))
end
