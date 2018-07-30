# coding: utf-8

#* mysh/internal/actions/command_line/init.rb -- The mysh init and no-init commands.
module Mysh

  #* mysh/internal/actions/command_line/init.rb -- The mysh init command.
  class InitOption < CommandOption

    #Skip over the argument for pre_boot.
    def pre_boot(read_point)
      file_name = get_arg(read_point).to_host_spec

      if $mysh_init_file
        $mysh_init_file = $mysh_init_file.in_array + [file_name]
      else
        $mysh_init_file = file_name
      end

      mysh "load #{file_name}"
    end

    #Execute the init command line option.
    def post_boot(read_point)
      get_arg(read_point)
    end

  end

  #Add the init command line option to the library.
  desc = 'Initialize mysh by loading the specified file.'
  COMMAND_LINE.add_action(InitOption.new('--init filename', desc))
  COMMAND_LINE.add_action(InitOption.new('-i filename', desc))


  #* mysh/internal/actions/command_line/init.rb -- The mysh no init command.
  class NoInitOption < CommandOption

    #Skip over the argument for pre_boot.
    def pre_boot(_args)
      fail "The mysh is already initialized." if $mysh_init_file
      $mysh_init_file = "<none>"
    end

  end

  #Add the no init command line option to the library.
  desc = 'Do not load a file to initialize mysh.'
  COMMAND_LINE.add_action(NoInitOption.new('--no-init', desc))
  COMMAND_LINE.add_action(NoInitOption.new('-ni', desc))
end
