# coding: utf-8

#* internal/actions/vls.rb -- The mysh module version ls command.
module Mysh

  #* internal/actions/vls.rb -- The mysh module version ls command.
  class Action

    desc = 'Display the loaded modules, matching the optional mask, ' +
           'that have version info.'

    COMMANDS.add('vls <mask>', desc) do |args|
      mask = args.shift || /./

      puts VersionLS.vls(mask).mysh_bulletize.join("\n")
      puts
    end

  end

end

