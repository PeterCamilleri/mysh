# coding: utf-8

#* mysh/internal/actions/prompt.rb -- The mysh post prompt command.
module Mysh

  #* mysh/internal/actions/post_prompt.rb -- The mysh post prompt command.
  class PostpromptOption < CommandOption

    #Skip over the argument for pre_boot.
    def pre_boot(read_point)
      get_arg(read_point)
    end

    #Execute the prompt command line option.
    def post_boot(read_point)
      MNV[:post_prompt] = get_arg(read_point)
    end

  end

  #Add the post prompt command line option to the library.
  desc = 'Set the mysh post prompt to "str".'
  COMMAND_LINE.add_action(PostpromptOption.new('--post-prompt "str"', desc))
  COMMAND_LINE.add_action(PostpromptOption.new('-pp "str"', desc))

  #* mysh/internal/actions/post_prompt.rb -- The mysh command no post prompt.
  class NoPostpromptOption < CommandOption

    #Execute the no post prompt command line option.
    def post_boot(_args)
      MNV[:post_prompt] = ""
    end

  end

  #Add the prompt command line option to the library.
  desc = 'Turn off mysh post prompting.'
  COMMAND_LINE.add_action(NoPostpromptOption.new('--no-post-prompt', desc))
  COMMAND_LINE.add_action(NoPostpromptOption.new('-npp', desc))
end
