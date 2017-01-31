# coding: utf-8

require 'vls'

#* mysh/internal/actions/vls.rb -- The mysh module vls (Version LS) command.
module Mysh

  #Add the vls command to the library.
  desc = 'Display the loaded modules, matching the optional mask, that ' +
         'have version info.'

  action = lambda do |input|
    filter  = input.args[0] || /./
    results = VersionLS.vls(filter)

    if results.empty?
      puts "No modules found for filter #{filter.inspect}.", ""
    else
      puts results.format_mysh_bullets, ""
    end
  end

  COMMANDS.add_action(Action.new('vls <mask>', desc, &action))
end
