# coding: utf-8

require 'pp'
require 'mathn'

require_relative 'expression/lineage'

#* mysh/expression.rb -- The mysh ruby expression processor.
#<br>Endemic Code Smells
#* :reek:ModuleInitialize
module Mysh

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

      #Do the actual work of executing an expression.
      #<br>Note:
      #* The expression string always begins with an '=' character.
      def execute(expression)
        pp $mysh_exec_binding.eval("$mysh_exec_result" + expression)
      rescue Interrupt, StandardError, ScriptError => err
        puts "#{err.class.to_s}: #{err}"
      ensure
        return :expression
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
