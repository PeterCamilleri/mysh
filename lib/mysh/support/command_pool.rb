# coding: utf-8

#* support/command_pool.rb -- A managed hash of mysh commands.
module Mysh

  #* support/command_pool.rb -- A managed hash of mysh commands.
  class CommandPool

    #Create a new command pool
    def initialize(&default_action)
      @pool = {}

      if default_action
        @pool.default = Command.new("", "", &default_action)
      end
    end

    #Get a command.
    def [](index)
      @pool[index]
    end

    #Add a command.
    def add(name, description, &action)
      @pool[name.split[0] || ""] = Command.new(name, description, &action)
    end

    #Add an alias for an existing command.
    def add_alias(new_name, old_name)
      unless (command = @pool[old_name])
        fail "Error adding alias #{new_name} for #{old_name}"
      end

      split_name = new_name.split[0]

      @pool[split_name] = Command.new(new_name,
                                      command.description,
                                      &command.action)
    end

    #Get information on all commands.
    def command_info
      @pool
        .values
        .map  {|command| command.command_info }
        .sort {|first, second| first[0] <=> second[0] }
    end

  end


end

