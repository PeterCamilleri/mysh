# coding: utf-8

# The mysh console command source.
module Mysh

  # A wrapper for the mysh console terminal.
  class Console

    # Setup the console wrapper.
    def initialize
      @eoi = false
    end

    # Get the initial line of command input.
    def get_command
      puts MNV[:pre_prompt] if MNV.key?(:pre_prompt)
      get(prompt: MNV[:prompt])
    rescue MiniReadlinePLE => err
      retry unless handle_get_error(err, :prompt)
      exit
    end

    # Get additional lines of continued commands.
    def get_command_extra(str)
      get(prompt: MNV[:post_prompt] + '\\', prefix: str[0])
    rescue MiniReadlinePLE => err
      retry unless handle_get_error(err, :post_prompt)
      exit
    end

    # Handle a readline error
    def handle_get_error(err, selector)
      puts "Error #{err.class}: #{err}"
      puts err.backtrace if MNV[:debug]

      MNV[selector].empty?
    ensure
      MNV[selector] = ""
    end

    # Have we reached the end of input?
    def eoi?
      @eoi
    end

    private

    # Get some actual user input!
    def get(parms={})
      parms[:history] = MNV[:history].extract_boolean
      parms[:no_dups] = MNV[:no_dups].extract_boolean
      parms[:no_move] = MNV[:no_move].extract_boolean

      result = (input = Mysh.input).readline(parms)
      input.instance_options[:initial] = ""
      result
    rescue MiniReadlineEOI
      @eoi = true
      "\n"
    end

  end

end
