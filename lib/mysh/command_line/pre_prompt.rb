# coding: utf-8

# The mysh pre_prompt command.
module Mysh

  # The mysh pre_prompt command.
  class PrepromptOption < CommandOption

    # Skip over the argument for pre_boot.
    def pre_boot(read_point)
      get_arg(read_point)
    end

    # Execute the prompt command line option.
    # Endemic Code Smells   :reek:UtilityFunction
    def post_boot(read_point)
      MNV[:pre_prompt] = get_arg(read_point)
    end

  end

  # Add the pre prompt command line option to the library.
  desc = 'Set the mysh pre prompt to "str".'
  COMMAND_LINE.add_action(PrepromptOption.new('--pre-prompt "str"', desc))
  COMMAND_LINE.add_action(PrepromptOption.new('-pr "str"', desc))

  # The mysh command no pre_prompt.
  class NoPrepromptOption < CommandOption

    # Execute the no pre_prompt command line option.
    # Endemic Code Smells   :reek:UtilityFunction
    def post_boot(_args)
      MNV[:pre_prompt] = ""
    end

  end

  # Add the prompt command line option to the library.
  desc = 'Turn off mysh pre prompting.'
  COMMAND_LINE.add_action(NoPrepromptOption.new('--no-pre-prompt', desc))
  COMMAND_LINE.add_action(NoPrepromptOption.new('-npr', desc))
end
