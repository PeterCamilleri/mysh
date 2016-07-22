# coding: utf-8

#* commands/exit.rb -- The mysh internal exit command.
module Mysh

  #* exit.rb -- The mysh internal exit command.
  class InternalCommand
    #Add the exit command to the library.
    add(self.new('help', 'display help information for mysh.') do |args|
      puts "mysh (MY SHell) version: #{Mysh::VERSION}"
      puts

      width = 0

      InternalCommand
        .info
        .sort do |first, second |
          width = [width, first[0].length, second[0].length].max
          first[0] <=> second[0]
        end
        .each do |info|
          puts "#{info[0].ljust(width)} - #{info[1]}"
        end
    end)

    add_alias('?', 'help')
  end
end

