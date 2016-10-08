# coding: utf-8

#* internal/actions/help.rb -- The mysh internal help command.
module Mysh

  #* help.rb -- The mysh internal help command.
  class Action

    # Help topics
    HELP = ActionPool.new("HELP") do |args|
      puts "No help found for #{args[0].inspect}."
    end

    HELP.add("", "General help on mysh.") do |args|
      show_handlebar_file(ACTIONS_PATH + 'help.txt')
    end

    HELP.add("math", "Help on mysh math functions.") do |args|
      show_handlebar_file(ACTIONS_PATH + 'help_math.txt')
    end

    HELP.add("=", "Help on mysh ruby expressions.") do |args|
      show_handlebar_file(ACTIONS_PATH + 'help_expr.txt')
    end

    HELP.add("help", "Help on mysh help.") do |args|
      show_handlebar_file(ACTIONS_PATH + 'help_help.txt')
    end

    HELP.add_alias('?', 'help')

    # The base help command.
    desc = 'Display help information for mysh with an optional topic.'

    COMMANDS.add('help <topic>', desc) do |args|
      HELP[args[0] || ""].execute(args)
    end

    COMMANDS.add_alias('? <topic>', 'help')

  end

end

