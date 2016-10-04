# coding: utf-8

#* commands/history.rb -- The mysh internal history command.
module Mysh

  #* history.rb -- The mysh internal history command.
  class Action
    #Add the exit command to the library.
    COMMANDS.add('history', 'Display the mysh command history.') do |args|
      history = Mysh.input.history

      #The history command should not be part of the history.
      history.pop

      puts history
    end

    COMMANDS.add_alias('!', 'history')
  end
end

