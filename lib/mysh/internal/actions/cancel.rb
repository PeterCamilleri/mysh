# coding: utf-8

#The mysh internal cancel command.
module Mysh

  #Add the cancel command to the library.
  desc = 'Cancel the current mysh level.'
  action = lambda {|_input| cancel}

  COMMANDS.add_action(Action.new('cancel', desc, &action))
end
