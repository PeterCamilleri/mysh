# coding: utf-8

# Get help on the term environment.
module Mysh

  # Get help on the term environment.
  class TermInfoCommand < Action

    #Execute the @term shell command.
    def process_command(_args)
      print WORKING unless @ran_once

      puts "Key term information.", "",
           info.format_mysh_bullets, ""

      @ran_once = true
    end

    private

    # Get the info
    # Endemic Code Smells :reek:UtilityFunction
    def info
      [["about",     MiniReadline::DESCRIPTION],
       ["version",   MiniReadline::VERSION],
       ["installed", Gem::Specification.find_all_by_name("mini_readline")
                                       .map{|s| s.version.to_s}
                                       .join(", ")],
       ["about",     MiniTerm::DESCRIPTION],
       ["version",   MiniTerm::VERSION],
       ["installed", Gem::Specification.find_all_by_name("mini_term")
                                       .map{|s| s.version.to_s}
                                       .join(", ")],
       ["latest",    Gem.latest_version_for("mini_term").to_s],
       ["code page", if MiniTerm.windows?; (`chcp`); end],
       ["term",      ENV['TERM']],
       ["disp",      ENV['DISPLAY']],
       ["edit",      ENV['EDITOR']]
      ]
    end



  end

  desc = 'Get information about the console. See ?term for more.'
  SHOW.add_action(TermInfoCommand.new('term', desc))
end
