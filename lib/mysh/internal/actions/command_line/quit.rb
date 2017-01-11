# coding: utf-8

#* mysh/internal/actions/quit.rb -- The mysh quit command.
module Mysh

  #* mysh/internal/actions/quit.rb -- The mysh quit command.
  class QuitOption < CommandOption

    #Execute the quit command line option.
    def post_boot(_args)
      exit
    end

  end

  #Add the quit command line option to the library.
  desc = 'Quit out of the mysh program.'
  COMMAND_LINE.add_action(QuitOption.new('--quit', desc))
end
