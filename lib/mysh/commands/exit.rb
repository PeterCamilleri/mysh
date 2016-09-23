# coding: utf-8

#* commands/exit.rb -- The mysh internal exit command.
module Mysh

  #* exit.rb -- The mysh internal exit command.
  class InternalCommand
    #Add the exit command to the library.
    add('exit', 'Exit mysh.') do |args|
      raise MiniReadlineEOI
    end

    add_alias('quit', 'exit')
  end
end

