# coding: utf-8

#* mysh/internal/actions/help.rb -- The mysh internal help command.
module Mysh

  # Help action pool of topics.
  COMMAND_LINE = ActionPool.new("COMMAND_LINE") do |args|
    fail "Error: Invalid command line option: #{args[0].inspect}."
  end

end

#Load up the extra help actions!
Dir[Mysh::Action::ACTIONS_PATH + 'command_line/*.rb'].each {|file| require file }
