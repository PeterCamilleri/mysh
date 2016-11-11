# coding: utf-8

require 'pp'
require 'mathn'

require_relative 'expression/lineage'

#* mysh/expression.rb -- The mysh ruby expression processor.
module Mysh

  #Reset the state of the execution hosting environment.
  #<br>Endemic Code Smells
  # :reek:TooManyStatements -- False positive
  def self.reset_host
    exec_class = Class.new do

      include Math

      #Set up a new execution environment
      #<br>Endemic Code Smells
      # :reek:ModuleInitialize -- False positive turned off in mysh.reek
      def initialize
        $exec_result  = nil
        $exec_binding = binding
      end

      #Do the actual work of executing an expression. Recall that the str
      #parameter begins with an '=' character.
      def execute(str)
        pp $exec_binding.eval("$exec_result" + str)
        :expression
      rescue Interrupt, StandardError, ScriptError => err
        puts "#{err.class.to_s}: #{err}"
      end

      private

      #Get the previous result
      def result
         $exec_result
      end

      #Reset the state of the execution host.
      def reset
        Mysh.reset_host
        nil
      end

    end

    $exec_host = exec_class.new
  end
end
