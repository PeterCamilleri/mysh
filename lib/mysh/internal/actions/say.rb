# coding: utf-8

#* mysh/internal/actions/say.rb -- A mysh internal say command.
module Mysh

  #Add says to the library.
  desc = 'Display the text in the command arguments.'
  action = lambda {|args| puts args.join(' ')}

  COMMANDS.add_action(Action.new('say <stuff>', desc, &action))
end
