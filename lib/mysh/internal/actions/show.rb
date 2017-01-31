# coding: utf-8

#* mysh/internal/actions/show.rb -- The mysh internal show command.
module Mysh

  #Show items.
  default = Action.new do |input|
    puts "No show data found for #{input.raw.inspect}. See ?@ for more."
  end

  SHOW = ActionPool.new("SHOW", default)

  #The shared description.
  desc = "Display information about a part of mysh. See ?@ for more."

  action = lambda do |input|
    item = input.args[0]

    if item.empty?
      puts "An item is needed for the show command."
    else
      SHOW[item].process_command(input)
    end
  end

  #The show command action object.
  COMMANDS.add_action(Action.new('show <item>', desc, &action))
  SHOW_COMMAND = Action.new('@<item>', desc, &action)
  COMMANDS.add_action(SHOW_COMMAND)
end

#Load up the extra help actions!
Dir[Mysh::Action::ACTIONS_PATH + 'show/*.rb'].each {|file| require file }
