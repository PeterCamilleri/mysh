# coding: utf-8

require 'pp'
require 'mathn'

#* expression.rb -- mysh ruby expression processor.
module Mysh

  #The mysh ruby expression processor.
  class ExecHost

    include Math

    #Get help info on Ruby host exec.
    def self.info
      [["=an_expr", "Display the result of evaluating an expression in ruby."],
       ["=result",  "Display the result of the previous evaluation."],
       ["=stuff \\","This expression is continued on the next line."]]
    end

    #The result of the previous expression.
    attr_reader :result

    #Process an expression.
    def execute(str)
      if str.start_with?('=')
        do_execute(str)
      else
        false
      end
    end

    #Reset the state of the execution host.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def reset
      Mysh.reset
      nil
    end

    private
    #Do the actual work of executing an expression.
    def do_execute(str)
      if /\\\s*$/ =~ str
        do_execute($` + "\n" + Mysh.input.readline(prompt: "mysh\\ "))
      else
        begin
          pp eval("@result" + str)
        rescue StandardError, ScriptError => err
          puts "Error: #{err}"
        end

        :expression
      end
    end
  end
end

