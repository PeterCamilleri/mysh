# coding: utf-8

#* support/manage.rb -- Manage mysh internal commands.
module Mysh

  #The mysh internal command class level data and methods.
  class InternalCommand

    #Set up the command library hash.
    COMMANDS = {}

    #Add a command to the command library.
    def self.add(name, description, target = COMMANDS, &action)
      target[name.split[0] || ""] = new(name, description, &action)
    end

    #Add an alias for an existing command.
    def self.add_alias(new_name, old_name, target=COMMANDS)
      unless (command = target[old_name])
        fail "Error adding alias #{new_name} for #{old_name}"
      end

      target[new_name] = new(new_name.split[0],
                                command.description,
                                &command.action)
    end

    #Execute an internal command
    def self.execute(str)
      unless str[0] == ' '
        command, args = parse(str.chomp)

        if (command)
          command.execute(args)
          :internal
        end
      end
    end

  end
end

