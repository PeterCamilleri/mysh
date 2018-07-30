# coding: utf-8

#* mysh/internal/actions/cd.rb -- The mysh internal cd command.
module Mysh

  #Add the cd command to the library.
  desc = 'Change directory to the optional <dir> parameter ' +
         'and then display the current working directory.'

  action = lambda do |input|
    args = input.args
    Dir.chdir(args[0]) unless args.empty?
    puts Dir.pwd.to_host_spec
  end

  COMMANDS.add_action(Action.new('cd <dir>', desc, &action))
end
