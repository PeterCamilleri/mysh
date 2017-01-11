# coding: utf-8

#* mysh/internal/actions/prompt.rb -- The mysh help command prompt.
module Mysh

  #* mysh/internal/actions/prompt.rb -- The mysh prompt command prompt.
  class PrepromptOption < CommandOption

    #Skip over the argument for pre_boot.
    def pre_boot(read_point)
      get_arg(read_point)
    end

    #Execute the prompt command line option.
    def post_boot(read_point)
      MNV[:pre_prompt] = get_arg(read_point)
    end

  end

  #Add the prompt command line option to the library.
  desc = 'Set the mysh pre prompt to "str".'
  COMMAND_LINE.add_action(PrepromptOption.new('--pre-prompt "str"', desc))
  COMMAND_LINE.add_action(PrepromptOption.new('-pr "str"', desc))

  #* mysh/internal/actions/prompt.rb -- The mysh prompt command no prompt.
  class NoPrepromptOption < CommandOption

    #Execute the prompt command line option.
    def post_boot(_args)
      MNV[:pre_prompt] = ""
    end

  end

  #Add the prompt command line option to the library.
  desc = 'Turn off mysh pre prompting.'
  COMMAND_LINE.add_action(NoPrepromptOption.new('--no-pre-prompt', desc))
  COMMAND_LINE.add_action(NoPrepromptOption.new('-npr', desc))
end
