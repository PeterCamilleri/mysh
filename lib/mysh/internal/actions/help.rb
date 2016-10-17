# coding: utf-8

#* internal/actions/help.rb -- The mysh internal help command.
module Mysh

  # Help topics
  HELP = ActionPool.new("HELP") do |args|
    puts "No help found for #{args[0].inspect}."
  end

  #* help.rb -- The mysh internal help command.
  class HelpCommand < Action

    #Execute a help command by routing it to a sub-command.
    def call(args)
      HELP[args[0] || ""].call(args)
    end

  end

  # The base help command.
  desc = 'Display help information for mysh with an optional topic.'
  COMMANDS.add_action(HelpCommand.new('help <topic>', desc))
  COMMANDS.add_action(HelpCommand.new('? <topic>', desc))


  #* help.rb -- The mysh internal help sub commands.
  class HelpSubCommand < Action

    #Setup a help command.
    def initialize(name, description, file_name)
      super(name, description)
      @file_name = file_name
    end

    #Execute a help command.
    def call(args)
      show_handlebar_file(ACTIONS_PATH + 'help/' + @file_name)
    end

    help = [['',     'General help on mysh.',              'help.txt'],
            ['math', 'Help on mysh math functions.',       'help_math.txt'],
            ['=',    'Help on mysh ruby expressions.',     'help_expr.txt'],
            ['gls',  'Help on gls internal mysh command.', 'help_expr.txt'],
            ['help', 'Help on mysh help.',                 'help_help.txt'],
            ['?',    'Help on mysh help.',                 'help_help.txt']
           ]

    help.each do |parms|
      HELP.add_action(HelpSubCommand.new(*parms))
    end

  end

end

#Load up the extra help actions!
Dir[Mysh::Action::ACTIONS_PATH + 'help/*.rb'].each {|file| require file }

