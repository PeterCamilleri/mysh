# coding: utf-8

#* mysh/internal/binding_wrapper.rb -- An action compatible wrapper for a binding.
module Mysh

  #* mysh/internal/binding_wrapper.rb -- An action compatible wrapper for a binding.
  class BindingWrapper

    #Setup a binding wrapper
    def initialize(binding)
      @exec_binding = binding
    end

    #Evaluate the string in the wrapped context.
    def mysh_eval(str)
      @exec_binding.eval(str)
    end

  end

end
