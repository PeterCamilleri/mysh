# coding: utf-8

module Mysh

  # The page pause option.
  class PauseOption < CommandOption

    #Execute the help command line option.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def post_boot(_args)
      MNV[:page_pause] = "on"
    end

  end

  #Add the pause command line option to the library.
  desc = 'Turn on page pauses.'
  COMMAND_LINE.add_action(PauseOption.new('--pause', desc))

  # The no page pause option.
  class NoPauseOption < CommandOption

    #Execute the help command line option.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def post_boot(_args)
      MNV[:page_pause] = "off"
    end

  end

  #Add the no pause command line option to the library.
  desc = 'Turn off page pauses.'
  COMMAND_LINE.add_action(NoPauseOption.new('--no-pause', desc))
end
