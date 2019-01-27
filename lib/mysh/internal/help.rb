# coding: utf-8

# The mysh internal help command.
module Mysh

  # Help action pool of topics.
  default = Action.new do |args|
    topic = args[0]
    help = []

    COMMANDS.actions_info.each do |cmd|
      help << cmd if cmd[0].start_with?(topic)
    end

    if help.empty?
      puts "No help found for #{topic.inspect}."
    else
      help.puts_format_output_bullets
    end
  end

  HELP = ActionPool.new("HELP", default)

  # The mysh internal help command.
  class HelpCommand < Action

    # Execute a help command by routing it to a sub-command.
    # Endemic Code Smells  :reek:UtilityFunction
    def process_command(input)
      args = input.args
      HELP[args[0] || ""].process_command(args)
    end

  end

  # The base help command.
  desc = 'Display help information for mysh with an optional topic. See ?? for more.'
  COMMANDS.add_action(HelpCommand.new('help <topic>', desc))

  #The help command action object.
  HELP_COMMAND = HelpCommand.new('?<topic>', desc)
  COMMANDS.add_action(HELP_COMMAND)
end

# Load in support for help sub-topics
require_relative 'help/sub_help'
