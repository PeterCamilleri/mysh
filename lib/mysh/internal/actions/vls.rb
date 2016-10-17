# coding: utf-8

require 'vls'

#* internal/actions/vls.rb -- The mysh module version ls command.
module Mysh

  #* internal/actions/vls.rb -- The mysh module version ls command.
  class Action

    desc = 'Display the loaded modules, matching the optional mask, ' +
           'that have version info.'

    COMMANDS.add('vls <mask>', desc) do |args|
      puts VersionLS.vls(args[0] || /./).mysh_bulletize.join("\n"), ""
    end

  end

end

