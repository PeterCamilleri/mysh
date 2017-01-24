# coding: utf-8

#* mysh/internal/action.rb -- The framework of mysh internal actions.
module Mysh

  #The mysh internal action class.
  class Action
    #The name of the action.
    attr_reader :name

    #The description of the action.
    attr_reader :description

    #Setup an internal action.
    def initialize(name, description)
      @name, @description = name, description.in_array
    end

    #Parse the string and call the action.
    def quick_parse_and_call(str)
      call(Mysh.parse_args(str[1..-1].chomp))
      :internal
    end

    #Get information about the action.
    def action_info
      [@name].concat(@description)
    end

    #Get the name without any argument descriptions.
    def short_name
      name.split[0] || ""
    end

  end

end
