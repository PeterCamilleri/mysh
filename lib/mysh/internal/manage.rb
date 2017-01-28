# coding: utf-8

#* mysh/internal/manage.rb -- Manage mysh internal commands.
module Mysh

  #Set up the command action pool.
  COMMANDS = ActionPool.new("COMMANDS")

  #Try to execute the string as an internal action.
  def self.try_execute_internal(input)
    unless input.quick_command == ' '
      if (action = COMMANDS[input.parsed[0]])
        action.process_command(input)
        :internal
      end
    end
  end

end

