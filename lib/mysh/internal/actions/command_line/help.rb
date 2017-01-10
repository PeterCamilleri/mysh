# coding: utf-8

#* mysh/internal/actions/help.rb -- The mysh help command line option.
module Mysh

  #* mysh/internal/actions/help.rb -- The mysh help command line option.
  class HelpOption < Action

    #Execute the help command line option.
    def call(_args)
      fail ""
    end

  end

  #Add the help command line option to the library.
  desc = 'Display mysh usage info and exit.'
  COMMAND_LINE.add_action(HelpOption.new('--help', desc))
  COMMAND_LINE.add_action(HelpOption.new('-h', desc))
  COMMAND_LINE.add_action(HelpOption.new('-?', desc))
end
