# coding: utf-8

#* mysh/internal/actions/command_line/load.rb -- The mysh load command.
module Mysh

  #* mysh/internal/actions/command_line/load.rb -- The mysh load command.
  class LoadOption < CommandOption

    #Skip over the argument for pre_boot.
    def pre_boot(read_point)
      get_arg(read_point)
    end

    #Execute the load command line option.
    def post_boot(read_point)
      mysh "load #{get_arg(read_point).to_host_spec}"
    end

  end

  #Add the load command line option to the library.
  desc = 'Load the specified file into the mysh.'
  COMMAND_LINE.add_action(LoadOption.new('--load filename', desc))
  COMMAND_LINE.add_action(LoadOption.new('-l filename', desc))
end
