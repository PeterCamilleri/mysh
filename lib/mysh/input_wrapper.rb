# coding: utf-8

# An action compatible wrapper for a input.
module Mysh

  # An action compatible wrapper for a input.
  class InputWrapper

    # Build an input wrapper.
    def initialize(raw)
      @raw = raw.chomp
      @raw_command = @raw_body = nil
    end

    # Access the raw text.
    attr_reader :raw

    # Get the first raw character.
    def quick_command
      @raw[0] || ""
    end

    # Get the balance of the raw string.
    def quick_body
      @raw[1..-1] || ""
    end

    # Get the command word if it exists.
    def raw_command
      @raw_command ||= @raw.split[0] || ""
    end

    # Get the parameter text.
    def raw_body
      @raw_body ||= @raw[(raw_command.length + 1)..-1] || ""
    end

    # Get the preprocessed argument text.
    def cooked_body
      raw_body.preprocess
    end

    # Access the massaged text.
    def cooked
      body = cooked_body
      raw_command + (body.empty? ? "" : " " + body)
    end

    # Get the parsed arguments
    def args
      Mysh.parse_args(cooked_body)
    end

    # Get the parsed command line.
    def parsed
      [raw_command] + args
    end

    # Set up input for a quick style command.
    def quick
      @raw_command = quick_command
      @raw_body    = quick_body
      self
    end

  end

end
