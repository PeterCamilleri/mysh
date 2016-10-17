# coding: utf-8

#* internal/actions/cd.rb -- The mysh internal cd command.
module Mysh

  #* cd.rb -- The mysh internal cd command.
  class CdCommand < Action

    #Execute the cd command.
    def execute(args)
      Dir.chdir(args[0]) unless args.empty?
      puts decorate(Dir.pwd)
    rescue => err
      puts "Error: #{err}"
    end

  end

  #Add the cd command to the library.
  desc = 'Change directory to the optional <dir> parameter ' +
         'and then display the current working directory.'
  COMMANDS.add_action(CdCommand.new('cd <dir>', desc))
end
