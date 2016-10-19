# coding: utf-8

#* internal/actions/help.rb -- The mysh internal help command.
module Mysh

  #* help.rb -- The mysh internal help sub commands.
  class HelpSubCommand < Action

    #Setup a help command.
    def initialize(name, description, file_name)
      super(name, description)
      @file_name = file_name
    end

    #Execute a help command.
    def call(_args)
      show_handlebar_file(ACTIONS_PATH + 'help/' + @file_name)
    end

  end

  help = [['',     'General help on mysh.',               'help.txt'     ],
          ['show', 'Help on the mysh show command.',      'help_show.txt'],
          ['@',    'Help on the mysh show command.',      'help_show.txt'],
          ['math', 'Help on mysh math functions.',        'help_math.txt'],
          ['=',    'Help on mysh ruby expressions.',      'help_expr.txt'],
          ['gls',  'Help on gls internal mysh command.',  'help_gls.txt' ],
          ['help', 'This help on the mysh help command.', 'help_help.txt'],
          ['?',    'This help on the mysh help command.', 'help_help.txt']
         ]

  help.each do |parms|
    HELP.add_action(HelpSubCommand.new(*parms))
  end

end
