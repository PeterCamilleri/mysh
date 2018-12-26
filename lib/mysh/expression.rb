# coding: utf-8

require 'pp'
require_relative 'expression/lineage'

#* mysh/expression.rb -- The mysh ruby expression processor.
#<br>Endemic Code Smells
#* :reek:ModuleInitialize -- False positive
module Mysh

  #Set up some popular constants
  E = Math::E
  PI = Math::PI

  #Reset the state of the execution hosting environment.
  #<br>Endemic Code Smells
  # :reek:TooManyStatements -- False positive
  def self.reset_host
    exec_class = Class.new do

      include Math

      #Set up a new execution environment
      def initialize
        $mysh_exec_result  = nil
        $mysh_exec_binding = binding
      end

      #Return a simple message for less convoluted error messages.
      def inspect
        "exec_host"
      end

      private

      #Get the previous result
      def result
         $mysh_exec_result
      end

      #Reset the state of the execution host.
      def reset
        Mysh.reset_host
        nil
      end
    end

    $mysh_exec_host = exec_class.new
  end
end
