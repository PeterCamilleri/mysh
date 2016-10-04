# coding: utf-8

#* internal/manage.rb -- Manage mysh internal commands.
module Mysh

  #Set up the command library hash.
  COMMANDS = ActionPool.new

  #Parse a command string for use by commands.
  def self.parse_command(str)
    result = Mysh.parse_args(str.chomp)

    [COMMANDS[result.shift], result]
  end

  #Execute an internal command
  def self.execute(str)
    unless str[0] == ' '
      command, args = parse_command(str.chomp)

      if (command)
        command.execute(args)
        :internal
      end
    end
  end

  #Try to execute the string as an internal command.
  def self.try_execute_internal_command(str)
    execute(str)
  end

end

