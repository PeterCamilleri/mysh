# coding: utf-8

#* mysh/internal/actions/history.rb -- The mysh internal history command.
module Mysh

  #* mysh/internal/actions/history.rb -- The mysh internal history command.
  class HistoryCommand < Action

    #Execute the history command.
    def call(_args)
      history = Mysh.input.history

      #The history command should not be part of the history.
      history.pop

      history.each_with_index do |item, index|
        puts "#{index+1}: #{item}"
      end
    end

  end

  #Add the history commands to the library.
  desc = 'Display the mysh command history, or if an index is specified, ' +
         'retrieve the command with that index value.'
  COMMANDS.add_action(HistoryCommand.new('history <index>', desc))
  #The history command action object.
  HISTORY_COMMAND = HistoryCommand.new('!<index>', desc)
  COMMANDS.add_action(HISTORY_COMMAND)
end
