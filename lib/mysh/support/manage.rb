# coding: utf-8

#* support/manage.rb -- Manage mysh internal commands.
module Mysh

  #The mysh internal command class level data and methods.
  class Command

    #Set up the command library hash.
    COMMANDS = CommandPool.new

    #Execute an internal command
    def self.execute(str)
      unless str[0] == ' '
        command, args = Mysh.parse_command(str.chomp)

        if (command)
          command.execute(args)
          :internal
        end
      end
    end

  end
end

