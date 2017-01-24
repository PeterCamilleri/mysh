# coding: utf-8

#* mysh/internal/actions/quit.rb -- The mysh internal quit command.
module Mysh

  #* mysh/internal/actions/quit.rb -- The mysh internal quit command.
  class QuitCommand < Action

    #Execute the quit command.
    def process_command(_args)
      exit
    end

  end

  #Add the quit command to the library.
  COMMANDS.add_action(QuitCommand.new('quit', 'Quit out of the mysh.'))
end
