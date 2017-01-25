# coding: utf-8

#* mysh/internal/actions/pwd.rb -- The mysh internal pwd command.
module Mysh

  desc = 'Display the current working directory.'
  action = lambda {|_args| puts Dir.pwd.decorate}

  COMMANDS.add_action(Action.new('pwd', desc, &action))
end
