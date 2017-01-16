# coding: utf-8

#* mysh/internal/actions/command_line/debug.rb -- The mysh help command debug.
module Mysh

  #* mysh/internal/actions/command_line/debug.rb -- The mysh help command debug.
  class DebugOption < CommandOption

    #Execute the help command line option.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def post_boot(_args)
      MNV[:debug] = "on"
    end

  end

  #Add the debug command line option to the library.
  desc = 'Turn on mysh debugging.'
  COMMAND_LINE.add_action(DebugOption.new('--debug', desc))
  COMMAND_LINE.add_action(DebugOption.new('-d', desc))

  #* mysh/internal/actions/command_line/debug.rb -- The mysh help command no debug.
  class NoDebugOption < CommandOption

    #Execute the help command line option.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def post_boot(_args)
      MNV[:debug] = "off"
    end

  end

  #Add the debug command line option to the library.
  desc = 'Turn off mysh debugging.'
  COMMAND_LINE.add_action(NoDebugOption.new('--no-debug', desc))
  COMMAND_LINE.add_action(NoDebugOption.new('-nd', desc))
end
