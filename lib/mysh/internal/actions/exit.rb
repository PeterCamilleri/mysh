# coding: utf-8

#* internal/actions/exit.rb -- The mysh internal exit command.
module Mysh

  #* exit.rb -- The mysh internal exit command.
  class ExitCommand < Action

    #Execute the exit command.
    def call(args)
      raise MiniReadlineEOI
    end

  end

  #Add the exit command to the library.
  COMMANDS.add_action(ExitCommand.new('exit', 'Exit mysh.'))
  COMMANDS.add_action(ExitCommand.new('quit', 'Exit mysh.'))
end
