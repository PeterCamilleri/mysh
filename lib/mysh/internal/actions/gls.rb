# coding: utf-8

#* internal/actions/gls.rb -- The mysh gem ls command.
module Mysh

  #* internal/actions/gls.rb -- The mysh gem ls command.
  class Action

    desc = 'Display the loaded ruby gems.'

    COMMANDS.add('gls <mask>', desc) do |args|
      puts Gem.loaded_specs.keys.sort.join(" ")
      puts
    end

  end

end

