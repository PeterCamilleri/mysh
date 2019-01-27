# coding: utf-8

#* mysh/internal/actions/pwd.rb -- The mysh internal pwd command.
module Mysh

  desc = 'Display the current working directory.'
  action = lambda {|_input| puts Dir.pwd.to_host_spec}

  COMMANDS.add_action(Action.new('pwd', desc, &action))
end
