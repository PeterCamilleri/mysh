# coding: utf-8

# The mysh internal help sub commands.
module Mysh

  # The mysh internal help sub commands.
  class HelpSubCommand < Action

    # Setup a help command.
    def initialize(name, description, file_name)
      super(name, description)
      @file_name = file_name
    end

    #Execute a help command.
    def process_command(_args)
      path = MYSH_LIB + "mysh/help/" + @file_name
      mysh "load #{path.to_host_spec}"
    end

  end

  # Add help topics here. Don't sweat the order; they get sorted by name.
  #        Name        Description                            Help File
  help = [['',        'General help on mysh.',               'help.txt'   ],
          ['set',     'Help on mysh variables.',             'vars.txt'   ],
          ['show',    'Help on the show command.',           'show.txt'   ],
          ['@',       'Help on the show command.',           'show.txt'   ],
          ['%',       'Help on timed command execution.',    'timed.txt'  ],
          ['env',     'Help on the show env command.',       'env.txt'    ],
          ['ruby',    'Help on the show ruby command.',      'ruby.txt'   ],
          ['gem',     'Help on the show gem command.',       'gem.txt'    ],
          ['term',    'Help on the show term command.',      'term.txt'   ],
          ['math',    'Help on math functions.',             'math.txt'   ],
          ['usage',   'Help on mysh usage.',                 'usage.txt'  ],
          ['=',       'Help on ruby expressions.',           'expr.txt'   ],
          ['quick',   'Help on quick commands.',             'quick.txt'  ],
          ['gls',     'Help on the gls command.',            'gls.txt'    ],
          ['mls',     'Help on the mls command.',            'mls.txt'    ],
          ['!',       'Help on the history command.',        'history.txt'],
          ['history', 'Help on the history command.',        'history.txt'],
          ['kbd',     'Help on mysh keyboard mapping.',      'kbd.txt'    ],
          ['{{',      'Help on mysh handlebars.',            'hbar.txt'   ],
          ['init',    'Help on mysh initialization.',        'init.txt'   ],
          ['type',    'Help on the type command.',           'type.txt'   ],
          ['types',   'Help on mysh file types.',            'types.txt'  ],
          ['help',    'This help on the help command.',      'h_o_h.txt'  ],
          ['?',       'This help on the help command.',      'h_o_h.txt'  ]
         ]

  help.each do |parms|
    HELP.add_action(HelpSubCommand.new(*parms))
  end

end
