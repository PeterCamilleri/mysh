# coding: utf-8

require 'pp'

#* expression.rb -- mysh ruby expression processor.
module Mysh

  #The mysh ruby expression processor.
  class ExecHost

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
    def reset
      Mysh.reset
      nil
    end

    private
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

