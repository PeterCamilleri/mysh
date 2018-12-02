# coding: utf-8

#* mysh/internal/actions/quit.rb -- The mysh internal quit command.
module Mysh

  #Add the quit command to the library.
  desc = 'Quit out of the mysh.'

  COMMANDS.add_action(Action.new('quit', desc) {|_input| exit })
end
