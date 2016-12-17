# coding: utf-8

#* mysh/shell_variables/shell_variable_keeper.rb -- The keeper of mysh values.
module Mysh

  #The keeper of mysh variable values.
  class Keeper

    #Set up this variable
    def initialize(value="")
      @value = value
    end

    #Get the value of this variable.
    def get_value(loop_check={})
      my_id = self.object_id
      fail "Mysh variable looping error." if loop_check[my_id]
      loop_check[my_id] = self

      @value.eval_variables.eval_handlebars.eval_quoted_braces
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

