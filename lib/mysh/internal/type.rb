# coding: utf-8

#* mysh/internal/actions/type.rb -- The mysh type command.
module Mysh

  #Add the type command to the library.
  desc = 'Display a text file with support for optional embedded ' +
         'handlebars and mysh variables.'

  action = lambda do |input|
    count = 0

    input.args.each do |file_name|
      puts file_name
      show_handlebar_file(file_name, binding)
      count += 1
    end

    fail "A text file must be specified." if count == 0
  end

  COMMANDS.add_action(Action.new('type <files>', desc, &action))
end
