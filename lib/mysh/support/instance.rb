# coding: utf-8

#* support/instance.rb -- mysh internal command instance data and methods.
module Mysh

  #The mysh internal command instance data and methods.
  class InternalCommand
    #The name of the command.
    attr_reader :name

    #The description of the command.
    attr_reader :description

    #The action of the command.
    attr_reader :action

    #Setup an internal command
    def initialize(name, description, &action)
      @name        = name
      @description = description
      @action      = action
    end

    #Execute the command.
    def execute(args)
      @action.call(args)
    end

    #Get information about the command.
    def info
      [@name, @description]
    end

  end

end
