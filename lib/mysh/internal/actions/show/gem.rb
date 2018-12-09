# coding: utf-8

# Get help on the gem environment.
module Mysh

  # Get help on the gem environment.
  class GemInfoCommand < Action

    #Execute the @gem shell command.
    def process_command(input)
      print WORKING unless @ran_once

      args = input.cooked_body.split(" ")[1..-1]

      if args.empty?
        general
      else
        specific(args)
      end

      @ran_once = true
    end

    private

    # A general info request
    def general
      puts "Key gem system information.", "",
           info.format_mysh_bullets, "",
           path.format_mysh_bullets, ""
    end

    # Get the info
    # Endemic Code Smells :reek:UtilityFunction
    def info
      [["about",         "RubyGems is the ruby standard for publishing and " +
                         "managing third party libraries."],
       ["version",       Gem.rubygems_version.to_s],
       ["latest",        insouciant {Gem.latest_rubygems_version.to_s}],
       ["marshal",       Gem.marshal_version],
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

    # Get gem info on the specified gems
    def specific(args)
      details = []

      args.each do |gem|
        version_list = Gem::Specification.find_all_by_name(gem)
                                         .map{|s| s.version.to_s}
                                         .join(", ")
        details << [gem, version_list]

        latest = insouciant {latest_version_for(gem).to_s}
        details << ["latest", latest]
        details << [" ", " "]
      end

      puts "Info on specified gems.", "",
           details.format_mysh_bullets
    end

    # Get the latest version for the named gem. Patched code.
    def latest_version_for(name)
      dependency = Gem::Dependency.new(name)
      fetcher = Gem::SpecFetcher.fetcher
      spec = fetcher.spec_for_dependency(dependency)[0][-1][0]
      spec && spec.version
    end

  end

  desc = 'Get information about the current gem support or ' +
         'the specified list of gems. See ?gem for more.'
  SHOW.add_action(GemInfoCommand.new('gem <gems>', desc))
end
