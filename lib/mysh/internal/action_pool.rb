# coding: utf-8

#* internal/action_pool.rb -- A managed hash of mysh actions.
module Mysh

  #* A managed hash of mysh actions.
  class ActionPool

    #Create a new action pool
    def initialize(&default_action)
      @pool = {}

      if default_action
        @pool.default = Action.new("", "", &default_action)
      end
    end

    #Get a action.
    def [](index)
      @pool[index]
    end

    #Add a action.
    def add(name, description, &action)
      split_name = name.split[0] || ""

      @pool[split_name] = Action.new(name, description, &action)
    end

    #Add an alias for an existing action.
    def add_alias(new_name, old_name)
      unless (action = @pool[old_name])
        fail "Error adding alias #{new_name} for #{old_name}"
      end

      split_name = new_name.split[0]

      @pool[split_name] =
        Action.new(new_name, action.description, &action.action)
    end

    #Get information on all actions.
    def actions_info
      @pool
        .values
        .map  {|action| action.action_info }
        .sort {|first, second| first[0] <=> second[0] }
    end

  end


end

