# coding: utf-8

#* internal/action_pool.rb -- A managed hash of mysh actions.
module Mysh

  #* A managed hash of mysh actions.
  class ActionPool

    #The name of this action pool.
    attr_reader :pool_name

    #Create a new action pool
    def initialize(pool_name, &default_action)
      @pool_name, @pool = pool_name, {}

      if default_action
        @pool.default = Action.new("", "", &default_action)
      end
    end

    #Get a action.
    def [](index)
      @pool[index]
    end

    #Add an action to the pool.
    def add_action(action)
      split_name = action.name.split[0] || ""

      if @pool.has_key?(split_name)
        fail "Add error: Action #{split_name.inspect} already exists in #{pool_name}."
      end

      @pool[split_name] = action
    end

    #Add a action.
    def add(name, description, &action)
      split_name = name.split[0] || ""

      if @pool.has_key?(split_name)
        fail "Add error: Action #{split_name.inspect} already exists in #{pool_name}."
      end

      @pool[split_name] = Action.new(name, description, &action)
    end

    #Add an alias for an existing action.
    def add_alias(new_name, old_name)
      unless (action = @pool[old_name.split[0]])
        fail "Alias error: Action #{old_name.inspect} not found in #{pool_name}"
      end

      add(new_name, action.description, &action.action)
    end

    #Get information on all actions.
    def actions_info
      @pool
        .values
        .map  {|action| action.action_info}
        .sort {|first, second| first[0] <=> second[0]}
    end

  end


end

