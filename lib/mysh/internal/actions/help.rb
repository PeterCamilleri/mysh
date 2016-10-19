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
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def call(args)
      HELP[args[0] || ""].call(args)
    end

  end

  # The base help command.
  desc = 'Display help information for mysh with an optional topic.'
  COMMANDS.add_action(HelpCommand.new('help <topic>', desc))
  HELP_COMMAND = HelpCommand.new('?<topic>', desc)
  COMMANDS.add_action(HELP_COMMAND)
end

require_relative 'help/sub_help'

#Load up the extra help actions!
Dir[Mysh::Action::ACTIONS_PATH + 'help/*.rb'].each {|file| require file }
