# coding: utf-8

#* commands/help.rb -- The mysh internal help command.
module Mysh

  #* help.rb -- The mysh internal help command.
  class InternalCommand

    HELP = CommandPool.new do |args|
      puts "No help found for #{args[0].inspect}."
    end

    HELP.add("", "Display general help on mysh.") do |args|
      show_file('help.txt')
    end

    HELP.add("math", "Display help on mysh math functions.") do |args|
      show_file('help_math.txt')
    end

    HELP.add("=", "Display help on mysh ruby expressions.") do |args|
      show_file('help_ruby.txt')
    end

    #Add the exit command to the library. This is done by digging
    #into the HELP command dictionary.
    COMMANDS.add('help', 'Display help information for mysh.') do |args|
      HELP[args[0] || ""].execute(args)
    end

    COMMANDS.add_alias('?', 'help')

  end

end

