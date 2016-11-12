# coding: utf-8

#* mysh/internal/manage.rb -- Manage mysh internal commands.
module Mysh

  #Set up the command action pool.
  COMMANDS = ActionPool.new("COMMANDS")

  #Parse a command string for use by commands.
  def self.parse_command(str)
    result = Mysh.parse_args(str.chomp)

    [COMMANDS[result.shift], result]
  end

  #Execute the action of an internal command.
  def self.execute(str)
    unless str[0] == ' '
      action, args = parse_command(str.chomp)

      if action
        action.call(args)
        :internal
      end
    end
  end

  #Try to execute the string as an internal action.
  def self.try_execute_internal_command(str)
    execute(str)
  end

end

