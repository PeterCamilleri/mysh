# coding: utf-8

#* mysh/internal/action.rb -- The framework of mysh internal actions.
module Mysh

  #The mysh internal action class.
  class Action
    #The name of the action.
    attr_reader :name

    #The description of the action.
    attr_reader :description

    #Setup an internal action.
    def initialize(name = "", description = "", &action)
      @name, @description = name, description.in_array

      define_singleton_method(:process_command, &action) if block_given?
    end

    #Parse the string and call the action.
    def process_quick_command(input)
      input.quick
      process_command(input)
      :internal
    end

    #Get information about the action.
    def action_info
      [@name].concat(@description)
    end

    #Get the name without any argument descriptions.
    def short_name
      name.split[0] || ""
    end

  end

end
