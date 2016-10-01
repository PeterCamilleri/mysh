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

      #The fiber that holds the execution binding.
      attr_accessor :exec_fiber

      #The execution binding used for ruby expressions.
      attr_accessor :exec_binding

      #The result or error returned from the ruby expression.
      attr_accessor :exec_result
    end

    #Set up a new execution environment
    #<br>Note
    #* The exec_result variable is needed because Fiber.yield messes up the
    #  return value on an exception, even if that exception is handled.
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
