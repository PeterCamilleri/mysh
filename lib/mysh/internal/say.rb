# coding: utf-8

# The mysh internal say command.
module Mysh

  #Add says to the library.
  desc = 'Display the text in the command arguments.'
  action = lambda {|input| puts input.cooked_body}

  COMMANDS.add_action(Action.new('say <stuff>', desc, &action))
end
