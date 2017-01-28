# coding: utf-8

#* mysh/internal/input_wrapper.rb -- An action compatible wrapper for a input.
module Mysh

  #* mysh/internal/input_wrapper.rb -- An action compatible wrapper for a input.
  class InputWrapper

    #Build an input wrapper.
    def initialize(raw)
      @raw = raw.chomp
      @cooked = @command = @body = @args = @parsed = nil
    end

    #Access the raw text.
    attr_reader :raw

    #Get the first raw character.
    def quick_command
      @raw[0] || ""
    end

    #Get the balance of the raw string.
    def quick_body
      @raw[1..-1] || ""
    end

    #Get the command word if it exists.
    def command
      @command ||= @raw.split[0] || ""
    end

    #Get the parameter text.
    def body
      @body ||= @raw[(command.length)..-1]
    end

    #Access the massaged text.
    def cooked
      @cooked ||= body.preprocess
    end

    #Get the parsed arguments
    def args
      @args ||= Mysh.parse_args(cooked)
    end

    #Get the parsed command line.
    def parsed
      @parsed ||= [command] + args
    end

    #Set up input for a quick style command.
    def quick
      @command = quick_command
      @body    = quick_body
      @cooked  = @args = @parsed = nil
      self
    end

  end

end
