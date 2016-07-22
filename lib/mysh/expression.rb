# coding: utf-8

#* expression.rb -- mysh ruby expression processor.
module Mysh

  #The mysh ruby expression processor.
  class ExecHost

    #The result of the previous expression.
    attr_reader :result

    #Process an expression.
    def execute(str)
      if str[0] == '='
        begin
          eval("@result" + str)
          puts @result
        rescue StandardError, ScriptError => err
          puts "Error: #{err}"
        end

        :expression
      else
        false
      end
    end

    #Reset the state of the execution host.
    def reset
      Mysh.reset
      nil
    end

  end
end

