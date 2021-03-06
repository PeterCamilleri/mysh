# coding: utf-8

# The mysh help command usage.
module Mysh

  # The mysh help command usage.
  class UsageOption < CommandOption

    # Execute the help command line option. (Punt to error handler with no msg)
    def pre_boot(_args)
      raise MyshUsage
    end

  end

  # Add the usage command line option to the library.
  desc = 'Display mysh usage info and exit.'

  USAGE = UsageOption.new('--help', desc)
  COMMAND_LINE.add_action(USAGE)
  COMMAND_LINE.add_action(UsageOption.new('-h', desc))
  COMMAND_LINE.add_action(UsageOption.new('-?', desc))
end
