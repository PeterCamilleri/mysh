# coding: utf-8

#* internal/klass.rb -- mysh internal command class level data and methods.
module Mysh

  #The mysh internal command class level data and methods.
  class InternalCommand

    #Set up the command library hash.
    @commands = {}

    class << self
      #The command library, a hash.
      attr_reader :commands
    end

    #Add a command to the command library.
    def self.add(command)
      @commands[command.name.split[0]] = command
    end

    #Add an alias for an existing command.
    def self.add_alias(new_name, old_name)
      unless (command = @commands[old_name])
        fail "Error adding alias #{new_name} for #{old_name}"
      end

      @commands[new_name] = new(new_name.split[0],
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

    #Get information on all commands.
    def self.info
      @commands.values.map { |command| command.info }
    end

  end
end

