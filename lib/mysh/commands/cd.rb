# coding: utf-8

#* commands/cd.rb -- The mysh internal cd command.
module Mysh

  #* cd.rb -- The mysh internal cd command.
  class InternalCommand
    #Add the cd command to the library.
    add(self.new('cd <dir>', 'Change directory to <dir> and display the new working directory.') do |args|
      begin
        Dir.chdir(args[0]) unless args.empty?
        puts decorate(Dir.pwd)
      rescue => err
        puts "Error: #{err}"
      end
    end)

    #Add the pwd command to the library.
    add(self.new('pwd', 'Display the current working directory.') do |args|
      begin
        puts decorate(Dir.pwd)
      rescue => err
        puts "Error: #{err}"
      end
    end)

  end
end

