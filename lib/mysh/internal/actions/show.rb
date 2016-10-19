# coding: utf-8

#* mysh/internal/actions/show.rb -- The mysh internal show command.
module Mysh

  #Show items.
  SHOW = ActionPool.new("SHOW") do |args|
    puts "No show data found for #{args[0].inspect}. See ?@ for more."
  end

  #* mysh/internal/actions/show.rb -- The mysh internal show command.
  class ShowCommand < Action

    #Execute a help command by routing it to a sub-command.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def call(args)
      if args.empty?
        puts "An item is needed for the show command."
      else
        SHOW[args[0]].call(args)
      end
    end

  end

  # The base help command.
  desc = 'Display information about a part of mysh. See ?@ for more.'
  COMMANDS.add_action(ShowCommand.new('show <item>', desc))
  #The show command action object.
  SHOW_COMMAND = ShowCommand.new('@<item>', desc)
  COMMANDS.add_action(SHOW_COMMAND)
end

#Load up the extra help actions!
Dir[Mysh::Action::ACTIONS_PATH + 'show/*.rb'].each {|file| require file }
