# coding: utf-8

#* internal/actions/help/shell.rb -- Get help on the shell environment.
module Mysh

  #* internal/actions/help/shell.rb -- Get help on the shell environment.
  class RubyInfoCommand < Action

    #Execute the ? shell command.
    def call(_args)
      puts "Key ruby environment information.", ""
      puts info.mysh_bulletize.join("\n"), "",
           path.mysh_bulletize.join("\n"), ""
    end

    private

    #Get the info
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def info
      [["location",    RbConfig.ruby],
       ["description", RUBY_DESCRIPTION],
       ["version",     RUBY_VERSION],
       ["patch",       RUBY_PATCHLEVEL],
       ["revision",    RUBY_REVISION],
       ["date",        RUBY_RELEASE_DATE],
       ["platform",    RUBY_PLATFORM],
       ["copyright",   RUBY_COPYRIGHT],
       ["engine",      RUBY_ENGINE]]
    end

    #Get the path.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def path
      [["$:"].concat($:)]
    end

  end

  desc = 'Get information about the current ruby environment.'
  HELP.add_action(RubyInfoCommand.new('ruby', desc))
end
