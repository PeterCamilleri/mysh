# coding: utf-8

# Get info on the ruby environment.
module Mysh

  # Get info on the ruby environment.
  class RubyInfoCommand < Action

    #Execute the @ruby shell command.
    def process_command(_input)
      puts "Key ruby environment information.", ""
      puts info.format_output_bullets, "",
           path.format_output_bullets, ""
    end

    private

    # Get the info
    # Endemic Code Smells :reek:UtilityFunction
    def info
      [["location",    RbConfig.ruby.to_host_spec],
       ["description", RUBY_DESCRIPTION],
       ["version",     RUBY_VERSION],
       ["jversion",    (JRUBY_VERSION rescue nil)],
       ["patch",       RUBY_PATCHLEVEL],
       ["revision",    RUBY_REVISION],
       ["date",        RUBY_RELEASE_DATE],
       ["platform",    RUBY_PLATFORM],
       ["copyright",   RUBY_COPYRIGHT],
       ["engine",      RUBY_ENGINE],
       ["host",        RbConfig::CONFIG['host']],
       ["host cpu",    RbConfig::CONFIG['host_cpu']],
       ["host os",     RbConfig::CONFIG['host_os']],
       ["host vendor", RbConfig::CONFIG['host_vendor']]
      ]
    end

    # Get the path.
    # Endemic Code Smells :reek:UtilityFunction
    def path
      [["$:"].concat($:)]
    end

  end

  desc = 'Get information about the current ruby environment. ' +
         'See ?ruby for more.'
  SHOW.add_action(RubyInfoCommand.new('ruby', desc))
end
