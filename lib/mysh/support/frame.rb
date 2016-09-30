# coding: utf-8

#* support/frame.rb -- The abstract frame of mysh internal commands.
module Mysh

  #The mysh internal command instance data and methods.
  class Command
    #The name of the command.
    attr_reader :name

    #The description of the command.
    attr_reader :description

    #The action of the command.
    attr_reader :action

    #Setup an internal command
    def initialize(name, description, &action)
      @name, @description, @action = name, description.in_array, action
    end

    #Execute the command.
    def execute(args)
      instance_exec(args, &@action)
    end

    #Get information about the command.
    def command_info
      [@name, @description]
    end

  end

end
