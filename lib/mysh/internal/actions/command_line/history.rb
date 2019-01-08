# coding: utf-8

# The mysh command line options for history and no_move.
module Mysh

  # The mysh command line options for history.
  class HistoryOption < CommandOption
    # Execute the history command line option.
    # Endemic Code Smells   :reek:UtilityFunction
    def post_boot(_args)
      MNV[:history] = "on"
    end
  end

  # Add the command line option to the library.
  desc = 'Turn on mysh command history.'
  COMMAND_LINE.add_action(HistoryOption.new('--history', desc))


  # The mysh command line options for no history.
  class NoHistoryOption < CommandOption
    # Execute the no history command line option.
    # Endemic Code Smells  :reek:UtilityFunction
    def post_boot(_args)
      MNV[:history] = "off"
    end
  end

  # Add the no history command line options to the library.
  desc = 'Turn off mysh command history.'
  COMMAND_LINE.add_action(NoHistoryOption.new('--no-history', desc))


  # The mysh command line no move option for history.
  class NoMoveHistoryOption < CommandOption
    # Execute the no move command line option.
    # Endemic Code Smells   :reek:UtilityFunction
    def post_boot(_args)
      MNV[:no_move] = "on"
    end
  end

  # Add the command line no move option to the library.
  desc = 'Turn off mysh command history shifting.'
  COMMAND_LINE.add_action(NoMoveHistoryOption.new('--no-move', desc))


  # The mysh command line do move option for history.
  class DoMoveHistoryOption < CommandOption
    # Execute the do move command line option.
    # Endemic Code Smells   :reek:UtilityFunction
    def post_boot(_args)
      MNV[:no_move] = "off"
    end
  end

  # Add the command line do move option to the library.
  desc = 'Turn on mysh command history shifting.'
  COMMAND_LINE.add_action(DoMoveHistoryOption.new('--do-move', desc))

end
