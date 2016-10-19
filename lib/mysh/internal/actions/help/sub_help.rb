# coding: utf-8

#* mysh/internal/actions/help/sub_help.rb -- The mysh internal help sub commands.
module Mysh

  #* mysh/internal/actions/help/sub_help.rb -- The mysh internal help sub commands.
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

  help = [['',        'General help on mysh.',               'help.txt'     ],
          ['show',    'Help on the show command.',           'help_show.txt'],
          ['@',       'Help on the show command.',           'help_show.txt'],
          ['env',     'Help on the show env command.',       'help_env.txt' ],
          ['ruby',    'Help on the show ruby command.',      'help_ruby.txt'],
          ['math',    'Help on math functions.',             'help_math.txt'],
          ['=',       'Help on ruby expressions.',           'help_expr.txt'],
          ['quick',   'Help on quick commands.',             'quick.txt'    ],
          ['gls',     'Help on gls internal mysh command.',  'help_gls.txt' ],
          ['!',       'This help on the history command.',   'history.txt'  ],
          ['history', 'This help on the history command.',   'history.txt'  ],
          ['help',    'This help on the help command.',      'help_help.txt'],
          ['?',       'This help on the help command.',      'help_help.txt']
         ]

  help.each do |parms|
    HELP.add_action(HelpSubCommand.new(*parms))
  end

end
