# coding: utf-8

#* commands/exit.rb -- The mysh internal exit command.
module Mysh

  #* exit.rb -- The mysh internal exit command.
  class InternalCommand
    #Add the exit command to the library.
    add('help', 'Display help information for mysh.') do |args|
      puts "mysh (MY ruby SHell) version: #{Mysh::VERSION}"
      puts

      if args.empty?
        puts IO.read(File.dirname(__FILE__) + '/help_internal.txt')
        InternalCommand.display_info(info)
        puts IO.read(File.dirname(__FILE__) + '/help.txt')
      elsif args[0] == 'math'
        puts IO.read(File.dirname(__FILE__) + '/help_math.txt')
      elsif args[0] == 'ruby'
        puts IO.read(File.dirname(__FILE__) + '/help_ruby.txt')
      else
        puts "help #{args[0]} ???"
      end

    end

    add_alias('?', 'help')

    #Display internal help information.
    def self.display_info(info)
      #Get the help info sorted.
      help_info = info.sort {|first, second | first[0] <=> second[0] }

      #Determine the width of the tag area.
      tag_width = help_info.max_by {|item| item[0].length}[0].length + 1

      #Display the information.
      help_info.each {|item| display_item(item, tag_width) }

      puts
    end

    #Display one item of help.
    def self.display_item(item, tag_width)
      tag = item[0]

      item[1].each do |detail|
        puts "#{tag.ljust(tag_width)} #{detail}"
        tag = ""
      end
    end

  end

end

