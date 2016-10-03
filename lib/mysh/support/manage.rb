# coding: utf-8

#* support/manage.rb -- Manage mysh internal commands.
module Mysh

  #The mysh internal command class level data and methods.
  class Command

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

  end

  #Try to execute the string as an internal command.
  def self.try_internal_execute(str)
    Command.execute(str)
  end


end

