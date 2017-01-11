# coding: utf-8

#* mysh/internal/actions/prompt.rb -- The mysh help command prompt.
module Mysh

  #* mysh/internal/actions/prompt.rb -- The mysh prompt command prompt.
  class PromptOption < CommandOption

    #Skip over the argument for pre_boot.
    def pre_boot(read_point)
      get_arg(read_point)
    end

    #Execute the prompt command line option.
    def post_boot(read_point)
      MNV[:prompt] = get_arg(read_point)
    end

  end

  #Add the prompt command line option to the library.
  desc = 'Set the mysh prompt to <str>.'
  COMMAND_LINE.add_action(PromptOption.new('--prompt <str>', desc))
  COMMAND_LINE.add_action(PromptOption.new('-p <str>', desc))

  #* mysh/internal/actions/prompt.rb -- The mysh prompt command no prompt.
  class NoPromptOption < CommandOption

    #Execute the prompt command line option.
    def post_boot(_args)
      MNV[:prompt] = ""
    end

  end

  #Add the prompt command line option to the library.
  desc = 'Turn off mysh prompting.'
  COMMAND_LINE.add_action(NoPromptOption.new('--no-prompt', desc))
  COMMAND_LINE.add_action(NoPromptOption.new('-np', desc))
end
