# coding: utf-8

# Storage for mysh variables.
module Mysh

  # The holder of mysh variables.
  module MNV
    # Set up the storage hash.
    @store = Hash.new { |_hash, _key| Keeper.new }

    # The shared loop checker for programmatic access.
    @loop_check = nil

    # Get the value of a variable.
    # Endemic Code Smells   :reek:TooManyStatements
    def self.[](index)
      keeper = get_keeper(index)

      if @loop_check
        keeper.get_value(@loop_check)
      else
        begin
          keeper.get_value(@loop_check = {})
        ensure
          @loop_check = nil
        end
      end
    end

    # Set the value of a variable.
    def self.[]=(index, value)
      unless value.empty?
        keeper = get_keeper(index)
        keeper.set_value(value)
        set_keeper(index, keeper)
      else
        delete_keeper(index)
      end

      value
    end

    # Get the value keeper of a variable.
    def self.get_keeper(index)
      @store[index]
    end

    # Set the value keeper of a variable.
    def self.set_keeper(index, keeper)
      @store[index] = keeper
    end

    # Delete the value keeper of a variable.
    def self.delete_keeper(index)
      @store.delete(index)
    end

    # Get the source code of a variable.
    def self.get_source(index)
      @store[index].get_source
    end

    # Does this entry exist?
    def self.key?(index)
      @store.key?(index)
    end

    # Get all the keys
    def self.keys
      @store.keys
    end

  end

end
