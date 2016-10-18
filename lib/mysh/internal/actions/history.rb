# coding: utf-8

#* internal/actions/history.rb -- The mysh internal history command.
module Mysh

  #* history.rb -- The mysh internal history command.
  class HistoryCommand < Action

    #Execute the history command.
    def call(_args)
      history = Mysh.input.history

      #The history command should not be part of the history.
      history.pop

      puts history
    end

  end

  #Add the history commands to the library.
  desc = 'Display the mysh command history.'
  COMMANDS.add_action(HistoryCommand.new('history', desc))
  COMMANDS.add_action(HistoryCommand.new('!',       desc))
end
