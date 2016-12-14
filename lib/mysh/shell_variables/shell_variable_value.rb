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

    #Get the source code of this variable.
    def get_source
      @value
    end

    #Set the value of this variable.
    def set_value(value)
      @value = value
    end


  end

end

