# coding: utf-8

# The mysh internal exit command.
module Mysh

  # Add the exit command to the library.
  desc = 'Exit out of the mysh.'

  COMMANDS.add_action(Action.new('exit', desc) {|_input| exit })
end
