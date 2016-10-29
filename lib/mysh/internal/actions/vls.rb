# coding: utf-8

require 'vls'

#* mysh/internal/actions/vls.rb -- The mysh module vls (Version LS) command.
module Mysh

  #* mysh/internal/actions/vls.rb -- The mysh module vls (Version LS) command.
  class VlsCommand < Action

    #Execute the vls command.
    def call(args)
      filter  = args[0] || /./
      results = VersionLS.vls(filter)

      if results.empty?
        puts "No modules found for filter #{filter.inspect}.", ""
      else
        puts results.mysh_bulletize, ""
      end
    end

  end

  #Add the vls command to the library.
  desc = 'Display the loaded modules, matching the optional mask, that ' +
         'have version info.'
  COMMANDS.add_action(VlsCommand.new('vls <mask>', desc))
end
