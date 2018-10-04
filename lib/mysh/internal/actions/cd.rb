# coding: utf-8

#* mysh/internal/actions/cd.rb -- The mysh internal cd command.
module Mysh

  #Add the cd command to the library.
  desc = 'Change directory to the optional <dir> parameter ' +
         'or display the current working directory.'

  action = lambda do |input|
    if (args = input.args).empty?
      puts Dir.pwd.to_host_spec
    else
      Dir.chdir(args[0]) unless args.empty?
    end
  end

  COMMANDS.add_action(Action.new('cd <dir>', desc, &action))
end
