# coding: utf-8

# Get help on the gem environment.
module Mysh

  # Get help on the gem environment.
  class GemInfoCommand < Action

    #Execute the @gem shell command.
    def process_command(_args)
      print WORKING unless @ran_once

      puts "Key gem system information.", "",
           info.format_mysh_bullets, "",
           path.format_mysh_bullets, ""

      @ran_once = true
    end

    private

    # Get the info
    # Endemic Code Smells :reek:UtilityFunction
    def info
      [["rubygems vers", Gem.rubygems_version.to_s],
       ["latest vers",   Gem.latest_rubygems_version.to_s],
       ["marshal vers",  Gem.marshal_version],
       ["host",          Gem.host],
       ["sources",       Gem.sources.map(&:to_s)],
       ["gem folder",    Gem.dir.to_host_spec],
       ["bin folder",    Gem.bindir.to_host_spec],
       ["config path",   Gem.config_file.to_host_spec],
       ["cert path",     Gem.default_cert_path.to_host_spec],
       ["key path",      Gem.default_key_path.to_host_spec],
       ["spec cache",    Gem.spec_cache_dir.to_host_spec],
       ["file suffixes", Gem.suffixes.map{|sfx| '"'+sfx+'"'}.join(", ")],
       ["gem dep files", Gem::GEM_DEP_FILES.map{|sfx| '"'+sfx+'"'}.join(", ")],
       ["gem platforms", Gem.platforms.map{|sfx| '"'+sfx.to_s+'"'}.join(", ")]
      ]
    end

    # Get the Gem path.
    # Endemic Code Smells :reek:UtilityFunction
    def path
      [["gem path"].concat(Gem.path)]
    end

  end

  desc = 'Get information about the current gem support. ' +
         'See ?gem for more.'
  SHOW.add_action(GemInfoCommand.new('gem', desc))
end
