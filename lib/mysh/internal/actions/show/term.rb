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
      [["code page", if MiniTerm.windows?; (`chcp`); end],
       ["term",      ENV['TERM']],
       ["disp",      ENV['DISPLAY']],
       ["edit",      ENV['EDITOR']]
      ]
    end



  end

  desc = 'Get information about the console. See ?term for more.'
  SHOW.add_action(TermInfoCommand.new('term', desc))
end
