# coding: utf-8

#* mysh/shell_variables/shell_variable_store.rb -- Storage for mysh variables.
module Mysh

  #The holder of mysh variables.
  module MNV
    #Set up the storage hash.
    @store = Hash.new { |_hash, _key| Value.new }

    #Get the value of a variable.
    def self.[](index)
      @store[index].get_value.extract_mysh_types
    end

    #Set the value of a variable.
    def self.[]=(index, value)
      unless value.empty?
        mysh_value = @store[index]
        mysh_value.set_value(value)
        @store[index] = mysh_value
      else
        @store.delete(index)
      end

      value
    end

    #Get the value object of a variable.
    def self.get_value(index)
      @store[index]
    end

    #Get the source code of a variable.
    def self.get_source(index)
      @store[index].get_source
    end

    #Does this entry exist?
    def self.key?(index)
      @store.key?(index)
    end

    #Get all the keys
    def self.keys
      @store.keys
    end

  end

end
