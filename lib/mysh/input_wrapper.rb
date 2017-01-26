# coding: utf-8

#* mysh/internal/input_wrapper.rb -- An action compatible wrapper for a input.
module Mysh

  #* mysh/internal/input_wrapper.rb -- An action compatible wrapper for a input.
  class InputWrapper

    #Build an input wrapper.
    def initialize(raw)
      @raw = raw.chomp
      @quick = @args = @parsed = @cooked = nil
    end

    #Access the raw text.
    attr_reader :raw

    #Get the first raw character.
    def head
      @raw[0] || ""
    end

    #Get the balance of the raw string.
    def body
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

    #Get the parsed command line.
    def parsed
      @parsed ||= Mysh.parse_args(cooked)
    end

    #Get the parsed arguments
    def args
      @args ||= parsed[1..-1]
    end

    def quick
      @parsed = [head] + Mysh.parse_args(cooked[1..-1] || "")
      self
    end

  end

end
