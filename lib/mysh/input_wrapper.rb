# coding: utf-8

#* mysh/internal/input_wrapper.rb -- An action compatible wrapper for a input.
module Mysh

  #* mysh/internal/input_wrapper.rb -- An action compatible wrapper for a input.
  class InputWrapper

    #Build an input wrapper.
    def initialize(raw)
      @raw = raw.chomp
      @args = @parsed = @cooked = nil
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

    #Access the massaged text.
    def cooked
      @cooked ||= @raw.preprocess
    end

    #Get the command word if it exists.
    def command
      @raw.split[0] || ""
    end

    #Get the parameter text.
    def body
      @raw[(command.length)..-1]
    end

    #Get the parsed command line.
    def parsed
      @parsed ||= Mysh.parse_args(cooked)
    end

    #Get the parsed arguments
    def args
      @args ||= parsed[1..-1]
    end

    #Set up input for a quick style command.
    def quick
      quick_cooked = quick_body.preprocess
      @cooked = quick_command + quick_cooked
      @args = Mysh.parse_args(quick_cooked)
      @parsed = [quick_command] + @args
      self
    end

  end

end
