# coding: utf-8

#* mysh/internal/actions/exit.rb -- The mysh internal exit command.
module Mysh

  #* mysh/internal/actions/exit.rb -- The mysh internal exit command.
  class ExitCommand < Action

    #Execute the exit command.
    def call(_args)
      raise MyshExit
    end

  end

  #Add the exit command to the library.
  COMMANDS.add_action(ExitCommand.new('exit', 'Exit the current mysh level.'))
end
