# coding: utf-8

#* commands/cd.rb -- The mysh internal cd command.
module Mysh

  #* cd.rb -- The mysh internal cd command.
  class InternalCommand
    #Add the exit command to the library.
    add(self.new('cd <dir>', 'Change directory to <dir>.') do |args|
      begin
        Dir.chdir(args[0])
        puts Dir.pwd
      rescue => err
        puts "Error: #{err}"
      end
    end)
  end
end

