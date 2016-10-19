# coding: utf-8

require 'pp'
require 'mathn'

require_relative 'expression/lineage'

#* mysh/expression.rb -- The mysh ruby expression processor.
module Mysh

  #The mysh ruby expression processor.
  class ExecHost

    include Math

    #These variables live here so that they are not part of the mysh
    #execution environment. This provides a little bit of isolation.
    class << self
      #The result of the last expression evaluated.
      attr_accessor :result

      #The execution binding used for ruby expressions.
      attr_accessor :exec_binding
    end

    #Set up a new execution environment
    def initialize(owner)
      @owner = owner
      mysh_binding
    end

    #Create a binding for mysh to execute expressions in.
    def mysh_binding
      ExecHost.exec_binding = binding
    end

    #Do the actual work of executing an expression.
    def execute(str)
      self.result = exec_binding.eval(str[1..-1])
      send(result ? :pp : :puts, result)
    rescue Interrupt, StandardError, ScriptError => err
      puts "#{err.class.to_s}: #{err}"
    end

    private

    #Get the execute binding.
    def exec_binding
      self.class.exec_binding
    end

    #Get the previous result
    def result
      self.class.result
    end

    #Set the current result
    def result=(value)
      self.class.result=value
    end

    #Reset the state of the execution host.
    def reset
      @owner.reset_host
      nil
    end

    #Evaluate the string in the my shell context.
    def mysh_eval(str)
      exec_binding.eval(str)
    end
  end

  #Reset the state of the execution hosting environment.
  def self.reset_host
    @exec_host = ExecHost.new(self)
  end

end
