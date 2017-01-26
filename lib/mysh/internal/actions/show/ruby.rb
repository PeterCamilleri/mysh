# coding: utf-8

#* mysh/internal/actions/show/ruby.rb -- Get help on the ruby environment.
module Mysh

  #* mysh/internal/actions/show/ruby.rb -- Get help on the ruby environment.
  class RubyInfoCommand < Action

    #Execute the ? shell command.
    def process_command(_input)
      puts "Key ruby environment information.", ""
      puts info.format_mysh_bullets, "",
           path.format_mysh_bullets, ""
    end

    private

    #Get the info
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def info
      [["location",    RbConfig.ruby.decorate],
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

    #Get the path.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def path
      [["$:"].concat($:)]
    end

  end

  desc = 'Get information about the current ruby environment. ' +
         'See ?ruby for more.'
  SHOW.add_action(RubyInfoCommand.new('ruby', desc))
end
