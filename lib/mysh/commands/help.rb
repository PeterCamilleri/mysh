# coding: utf-8

#* commands/exit.rb -- The mysh internal exit command.
module Mysh

  #* exit.rb -- The mysh internal exit command.
  class InternalCommand
    #Add the exit command to the library.
    add(self.new('help', 'Display help information for mysh.') do |args|
      puts "mysh (MY ruby SHell) version: #{Mysh::VERSION}"
      puts

      if args.empty?
        puts IO.read(File.dirname(__FILE__) + '/help_internal.txt')

        InternalCommand
          .info
          .sort {|first, second | first[0] <=> second[0] }
          .each {|info| puts "#{info[0].ljust(10)} #{info[1]}" }
        puts
        puts IO.read(File.dirname(__FILE__) + '/help.txt')
      elsif args[0] == 'math'
        puts IO.read(File.dirname(__FILE__) + '/help_math.txt')
      elsif args[0] == 'ruby'
        puts IO.read(File.dirname(__FILE__) + '/help_ruby.txt')
      else
        puts "help #{args[0]} ???"
      end

    end)

    add_alias('?', 'help')
  end
end
