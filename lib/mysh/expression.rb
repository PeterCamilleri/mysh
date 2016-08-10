# coding: utf-8

require 'pp'
require 'mathn'

#* expression.rb -- mysh ruby expression processor.
module Mysh

  #The mysh ruby expression processor.
  class ExecHost

    include Math

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
        parms = {
                 prompt: 'mysh\\ ',
                 auto_source: MiniReadline::QuotedFileFolderSource
                }

        do_execute($PREMATCH + "\n" + Mysh.input.readline(parms))
      else
        begin
          eval("@result" + str)
          pp @result unless @result.nil?
        rescue StandardError, ScriptError => err
          puts "Error: #{err}"
        end

        :expression
      end
    end
  end
end
