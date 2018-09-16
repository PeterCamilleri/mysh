# coding: utf-8

#* mysh/sources/console.rb -- The mysh console command source.
module Mysh

  #A wrapper for the mysh console terminal.
  class Console

    #Setup the console wrapper.
    def initialize
      @eoi = false
    end

    #Get the initial line of command input.
    def get_command
      puts MNV[:pre_prompt] if MNV.key?(:pre_prompt)
      get(prompt: MNV[:prompt] + '>')
    rescue => err
      retry unless handle_read_error(err, :prompt)
      exit
    end

    #Get additional lines of continued commands.
    def get_command_extra(str)
      get(prompt: MNV[:post_prompt] + '\\', prefix: str[0])
    rescue => err
      retry unless handle_read_error(err, :post_prompt)
      exit
    end

    # Handle a read error
    def handle_read_error(err, selector)
      puts "Error #{err.class}: #{err}"
      puts err.backtrace if MNV[:debug]

      empty = MNV[:post_prompt].empty?
      MNV[:post_prompt] = ""
      empty
    end

    #Have we reached the end of input?
    def eoi?
      @eoi
    end

    private

    #Get some actual user input!
    def get(parms={})
      result = (input = Mysh.input).readline(parms)
      input.instance_options[:initial] = ""
      result
    rescue MiniReadlineEOI
      @eoi = true
      "\n"
    end

  end

end
