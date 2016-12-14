# coding: utf-8

#* mysh/shell_variables/shell_variable_value.rb -- Storage of mysh values.
module Mysh

  #The holder of mysh variable values.
  class Value

    #Set up this variable
    def initialize
      @value = ""
    end

    #A regular expression for parsing embedded variables.
    PARSE_EXPR = /((\$[a-z][a-z0-9_]*)|(\$\$))(?=[^a-z0-9_]|$)/

    #Get the value of this variable.
    def get_value(loop_check={})
      my_id = self.object_id
      fail "Mysh variable looping error." if loop_check[my_id]
      loop_check[my_id] = self

      @value.gsub(PARSE_EXPR) do |str|
        str == '$$' ? '$' : MNV.store[str[1..-1].to_sym].get_value(loop_check)
      end
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

