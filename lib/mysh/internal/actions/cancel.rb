# coding: utf-8

# The mysh internal cancel command.
module Mysh

  # Add the cancel command to the library.
  desc = 'Cancel the current mysh level.'

  COMMANDS.add_action(Action.new('cancel', desc) {|_input| cancel})
end
