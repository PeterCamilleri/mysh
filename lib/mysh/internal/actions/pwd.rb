# coding: utf-8

#* mysh/internal/actions/pwd.rb -- The mysh internal pwd command.
module Mysh

  #* mysh/internal/actions/pwd.rb -- The mysh internal pwd command.
  class PwdCommand < Action

    #Execute the cd command.
    def call(_args)
      puts decorate(Dir.pwd)
    end

  end

  desc = 'Display the current working directory.'
  COMMANDS.add_action(PwdCommand.new('pwd', desc))
end
