# coding: utf-8

#* commands/help.rb -- The mysh internal help command.
module Mysh

  #* help.rb -- The mysh internal help command.
  class InternalCommand

    default = InternalCommand.new("", "") do |args|
      puts "No help found for #{args[0].inspect}."
    end

    HELP = Hash.new(default)

    add("", "Display general help on mysh.", HELP) do |args|
      show_file('help.txt')
    end

    add("math", "Display help on mysh math functions.", HELP) do |args|
      show_file('help_math.txt')
    end

    add("=", "Display help on mysh ruby expressions.", HELP) do |args|
      show_file('help_ruby.txt')
    end

    #Add the exit command to the library. This is done by digging
    #into the HELP command dictionary.
    add('help', 'Display help information for mysh.') do |args|
      HELP[args[0] || ""].execute(args)
    end

    add_alias('?', 'help')

  end

end

