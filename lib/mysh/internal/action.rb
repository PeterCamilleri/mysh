# coding: utf-8

#* internal/action.rb -- The framework of mysh internal actions.
module Mysh

  #The mysh internal action class.
  class Action
    #The name of the action.
    attr_reader :name

    #The description of the action.
    attr_reader :description

    #The action of the action.
    attr_reader :action

    #Setup an internal action.
    def initialize(name, description, &action)
      @name, @description, @action = name, description.in_array, action
    end

    #Execute the action.
    def execute(args)
      instance_exec(args, &@action)
    end

    #Get information about the action.
    def action_info
      [@name].concat(@description)
    end

  end

end
