# coding: utf-8

#* mysh/shell_variables/shell_variable_store.rb -- Storage for mysh variables.
module Mysh

  #The holder of mysh variables.
  module MNV
    #Set up the storage hash.
    @store = Hash.new { |_hash, _key| Keeper.new }

    #The shared loop checker for programmatic access.
    @loop_check = nil

    #Get the value of a variable.
    #<br>Endemic Code Smells
    #* :reek:TooManyStatements
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
      end.extract_mysh_types
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

    #Get the value keeper of a variable.
    def self.get_keeper(index)
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
