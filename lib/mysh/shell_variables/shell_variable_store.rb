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

  end

end
