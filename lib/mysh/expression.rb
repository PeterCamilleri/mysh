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

    class << self
      attr_accessor :result
      attr_accessor :exec_fiber
      attr_accessor :exec_binding
      attr_accessor :exec_result
    end

    #Set up a new execution environment
    def initialize
      ExecHost.result = nil

      ExecHost.exec_fiber = Fiber.new do |cmd|
        ExecHost.exec_binding = binding

        while true
          begin
            ExecHost.exec_result = ExecHost.exec_binding.eval(cmd)
          rescue StandardError, ScriptError => err
            ExecHost.exec_result = "#{err.class.to_s}: #{err}"
          end

          cmd = Fiber.yield
        end
      end

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
      ExecHost.exec_fiber.resume("ExecHost.result #{str}")
      result = ExecHost.exec_result
      send(result ? :pp : :puts, result)
      :expression
    end

    #Get the previous result
    def result
      self.class.result
    end
  end

end
