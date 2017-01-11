# coding: utf-8

#* mysh/internal/action_pool.rb -- A managed hash of mysh actions.
module Mysh

  #* A managed hash of mysh actions.
  class ActionPool

    #The name of this action pool.
    attr_reader :pool_name

    #Create a new action pool
    def initialize(pool_name, &default_action)
      @pool_name, @pool = pool_name, {}
      @pool.default = default_action
    end

    #Get a action.
    def [](index)
      @pool[index]
    end

    #Does this action exist?
    def exists?(index)
      @pool.has_key?(index)
    end

    #Add an action to the pool.
    def add_action(action)
      split_name = action.name.split[0] || ""

      if @pool.key?(split_name)
        fail "Add error: Action #{split_name.inspect} already exists in #{pool_name}."
      end

      @pool[split_name] = action
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
