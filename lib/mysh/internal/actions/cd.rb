# coding: utf-8

#* mysh/internal/actions/cd.rb -- The mysh internal cd command.
module Mysh

  #* mysh/internal/actions/cd.rb -- The mysh internal cd command.
  class CdCommand < Action

    #Execute the cd command.
    def call(args)
      Dir.chdir(args[0]) unless args.empty?
      puts Dir.pwd.decorate
    rescue => err
      puts "Error: #{err}"
      puts err.backtrace if MNV[:debug]
    end

  end

  #Add the cd command to the library.
  desc = 'Change directory to the optional <dir> parameter ' +
         'and then display the current working directory.'
  COMMANDS.add_action(CdCommand.new('cd <dir>', desc))
end
