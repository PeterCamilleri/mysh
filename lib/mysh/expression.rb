# coding: utf-8

require 'pp'
require 'mathn'

#* expression.rb -- mysh ruby expression processor.
#<br>Endemic Code Smells
#* :reek:Attribute
module Mysh

  #The mysh ruby expression processor.
  class ExecHost

    include Math

    #These variables live here so that they are not part of the mysh
    #execution environment. This provides a little isolation.
    class << self
      #The result of the last expression evaluated.
      attr_accessor :result

      #The execution binding used for ruby expressions.
      attr_accessor :exec_binding
    end

    #Set up a new execution environment
    def initialize
      mysh_binding
    end

    #Create a binding for mysh to execute expressions in.
    def mysh_binding
      ExecHost.exec_binding = binding
    end

    #Process an expression.
    def execute(str)
      if str.start_with?('=')
        begin
          ExecHost.result = ExecHost.exec_binding.eval(str[1..-1])
          send(result ? :pp : :puts, result)
        rescue Interrupt, StandardError, ScriptError => err
          puts "#{err.class.to_s}: #{err}"
        end

        :expr
      else
        false
      end
    end

    #Reset the state of the execution host.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def reset
      Mysh.reset_host
      nil
    end

    private

    #Get the previous result
    def result
      self.class.result
    end
  end

end
