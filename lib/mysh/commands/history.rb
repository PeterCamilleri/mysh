# coding: utf-8

#* commands/exit.rb -- The mysh internal exit command.
module Mysh

  #* exit.rb -- The mysh internal history command.
  class InternalCommand
    #Add the exit command to the library.
    add(self.new('history', 'display the command history.') do |args|
      history = Mysh.input.history

      #The history command should not be part of the history.
      history.pop

      puts history
    end)

    add_alias('!', 'history')
  end
end

