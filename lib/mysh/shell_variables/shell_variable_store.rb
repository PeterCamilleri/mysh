# coding: utf-8

#* mysh/shell_variables/shell_variable_store.rb -- Storage for mysh variables.
module Mysh

  #The holder of mysh variables.
  module MNV

    @store = Hash.new { |_hash, _key| Value.new }

    #Get the value of a variable.
    def self.[](index)
      @store[index].get_value
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

    #Get the source code of a variable.
    def self.get_source(index)
      @store[index].get_source
    end

    #Does this entry exist?
    def self.has_key?(index)
      @store.has_key?(index)
    end

  end

end
