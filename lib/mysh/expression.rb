# coding: utf-8

require 'pp'
require 'mathn'

#* expression.rb -- mysh ruby expression processor.
module Mysh

  #The mysh ruby expression processor.
  class ExecHost

    include Math

    @result = nil

    #The result of the previous expression.
    class << self
      attr_accessor :result
    end

    #Process an expression.
    def execute(str)
      if str.start_with?('=')
        do_execute(do_build(str))
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

    #Gather up the full string of the expression to evaluate.
    #<br>Endemic Code Smells
    #* :reek:TooManyStatements
    def do_build(str)
      if /\\\s*$/ =~ str
        parms = {prompt: 'mysh\\',
                 auto_source: MiniReadline::QuotedFileFolderSource}

        do_build($PREMATCH + "\n" + Mysh.input.readline(parms))
      else
        str
      end
    end

    #Execute the string
    def do_execute(str)
      instance_eval("ExecHost.result #{str}")
      send(@result ? :pp : :puts, result)
    rescue StandardError, ScriptError => err
      puts "Error: #{err}"
    ensure
      return :expression
    end

    #Get the previous result
    def result
      ExecHost.result
    end
  end

end
