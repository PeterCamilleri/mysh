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
    end

    #Get additional lines of continued commands.
    def get_command_extra(str)
      get(prompt: MNV[:post_prompt] + '\\', prefix: str[0])
    end

    #Have we reached the end of input?
    def eoi?
      @eoi
    end

    private

    #Get some actual user input!
    def get(parms={})
      Mysh.input.readline(parms)
    rescue MiniReadlineEOI
      @eoi = true
      "\n"
    end

  end

end
