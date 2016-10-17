# coding: utf-8

#* internal/actions/pwd.rb -- The mysh internal pwd command.
module Mysh

  #* pwd.rb -- The mysh internal pwd command.
  class PwdCommand < Action

    #Execute the cd command.
    def execute(args)
      puts decorate(Dir.pwd)
    end

  end

  desc = 'Display the current working directory.'
  COMMANDS.add_action(PwdCommand.new('pwd', desc))
end
