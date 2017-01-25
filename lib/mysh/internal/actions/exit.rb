# coding: utf-8

#* mysh/internal/actions/exit.rb -- The mysh internal exit command.
module Mysh

  #Add the exit command to the library.
  desc = 'Exit the current mysh level.'
  action = lambda {|_args| raise MyshExit}

  COMMANDS.add_action(Action.new('exit', desc, &action))
end
