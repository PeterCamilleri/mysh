# coding: utf-8

require 'vls'

#* internal/actions/vls.rb -- The mysh module version ls command.
module Mysh

  #* internal/actions/vls.rb -- The mysh module version ls command.
  class VlsCommand < Action

    #Execute the vls command.
    def execute(args)
      puts VersionLS.vls(args[0] || /./).mysh_bulletize.join("\n"), ""
    end

  end

  #Add the vls command to the library.
  desc = 'Display the loaded modules, matching the optional mask, that ' +
         'have version info.'
  COMMANDS.add_action(VlsCommand.new('vls <mask>', desc))
end
