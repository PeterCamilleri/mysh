# coding: utf-8

# The mysh quit command.
module Mysh

  # The mysh quit command.
  class QuitOption < CommandOption

    # Execute the quit command line option.
    def post_boot(_args)
      exit
    end

  end

  # Add the quit command line option to the library.
  desc = "Exit a nested mysh file or command."
  COMMAND_LINE.add_action(QuitOption.new('--quit', desc))
end
