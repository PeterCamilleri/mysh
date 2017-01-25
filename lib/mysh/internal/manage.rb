# coding: utf-8

#* mysh/internal/manage.rb -- Manage mysh internal commands.
module Mysh

  #Set up the command action pool.
  COMMANDS = ActionPool.new("COMMANDS")

  #Parse a command string for use by commands.
  def self.parse_command(str)
    result = parse_args(str.chomp)

    [COMMANDS[result.shift], result]
  end

  #Try to execute the string as an internal action.
  def self.try_execute_internal(str)
    unless str[0] == ' '
      action, args = parse_command(str.chomp)

      if action
        action.process_command(args)
        :internal
      end
    end
  end

end

