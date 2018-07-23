# coding: utf-8

#* mysh/internal/action_pool.rb -- A managed hash of mysh actions.
module Mysh

  #* A managed hash of mysh actions.
  class ActionPool

    #The name of this action pool.
    attr_reader :pool_name

    #Create a new action pool
    def initialize(pool_name, default_action = nil)
      @pool_name, @pool = pool_name, {}
      @pool.default = default_action
    end

    #Get a action.
    def [](index)
      @pool[index]
    end

    #Does this action exist?
    def exists?(index)
      @pool.key?(index)
    end

    #Add an action to the pool.
    def add_action(action)
      short_name = action.short_name

      if @pool.key?(short_name)
        fail "Add error: Action #{short_name.inspect} already exists in #{pool_name}."
      end

      @pool[short_name] = action
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
