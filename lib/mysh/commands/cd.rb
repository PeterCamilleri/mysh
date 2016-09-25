# coding: utf-8

#* commands/cd.rb -- The mysh internal cd command.
module Mysh

  #* cd.rb -- The mysh internal cd command.
  class InternalCommand
    #Add the cd command to the library.
    desc = ['Change directory to the optional <dir> parameter.',
            'Then display the current working directory.']

    add('cd <dir>', desc) do |args|
      begin
        Dir.chdir(args[0]) unless args.empty?
        puts decorate(Dir.pwd)
      rescue => err
        puts "Error: #{err}"
      end
    end

    #Add the pwd command to the library.
    add('pwd', 'Display the current working directory.') do |args|
      begin
        puts decorate(Dir.pwd)
      rescue => err
        puts "Error: #{err}"
      end
    end

  end
end

