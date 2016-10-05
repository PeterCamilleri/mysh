# coding: utf-8

#* internal/actions/exit.rb -- The mysh internal exit command.
module Mysh

  #* exit.rb -- The mysh internal exit command.
  class Action
    #Add the exit command to the library.
    COMMANDS.add('exit', 'Exit mysh.') do |args|
      raise MiniReadlineEOI
    end

    COMMANDS.add_alias('quit', 'exit')
  end
end
