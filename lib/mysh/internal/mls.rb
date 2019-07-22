# coding: utf-8

require 'vls'

# The mysh module ls command.
module Mysh

  # Add the mls command to the library.
  desc = 'Display modules with version info. See ?mls for more.'

  action = lambda do |input|
    filter  = input.args[0] || /./
    results = VersionLS.vls(filter)

    if results.empty?
      puts "No modules found for filter #{filter.inspect}.", ""
    else
      puts results.format_output_bullets, ""
    end
  end

  COMMANDS.add_action(Action.new('mls <mask>', desc, &action))
end
