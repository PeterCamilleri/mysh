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
    def process_command(_args)
      mysh "load #{(ACTIONS_PATH + 'help/' + @file_name).decorate}"
    end

  end

  #Add help topics here. Don't sweat the order; they get sorted by name.
  #        Name        Description                            Help File
  help = [['',        'General help on mysh.',               'help.txt'   ],
          ['$',       'Help on mysh variables.',             'vars.txt'   ],
          ['show',    'Help on the show command.',           'show.txt'   ],
          ['@',       'Help on the show command.',           'show.txt'   ],
          ['env',     'Help on the show env command.',       'env.txt'    ],
          ['ruby',    'Help on the show ruby command.',      'ruby.txt'   ],
          ['math',    'Help on math functions.',             'math.txt'   ],
          ['usage',   'Help on mysh usage.',                 'usage.txt'  ],
          ['=',       'Help on ruby expressions.',           'expr.txt'   ],
          ['quick',   'Help on quick commands.',             'quick.txt'  ],
          ['gls',     'Help on gls internal mysh command.',  'gls.txt'    ],
          ['!',       'Help on the history command.',        'history.txt'],
          ['history', 'Help on the history command.',        'history.txt'],
          ['kbd',     'Help on mysh keyboard mapping.',      'kbd.txt'    ],
          ['{{',      'Help on mysh handlebars.',            'hbar.txt'   ],
          ['help',    'This help on the help command.',      'h_o_h.txt'  ],
          ['?',       'This help on the help command.',      'h_o_h.txt'  ]
         ]

  help.each do |parms|
    HELP.add_action(HelpSubCommand.new(*parms))
  end

end
