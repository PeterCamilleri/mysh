# coding: utf-8

#* mysh/shell_variables/shell_variable_value.rb -- Storage of mysh values.
module Mysh

  #The holder of mysh variable values.
  class Value

    #Set up this variable
    def initialize
      @value = ""
    end

    #Get the value of this variable.
    def get_value
      @value
    end


  end


end

