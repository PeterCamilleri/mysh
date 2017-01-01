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

      parms = {prompt: MNV[:prompt] + '>'}
      Mysh.input.readline(parms)
    rescue MiniReadlineEOI
      @eoi = true
      "\n"
    end

    #Get additional lines of continued commands.
    def get_command_extra(str)
      parms = {prompt: MNV[:post_prompt] + '\\', prefix: str[0]}
      Mysh.input.readline(parms)
    rescue MiniReadlineEOI
      @eoi = true
      "\n"
    end

    #Have we reached the end of input?
    def eoi?
      @eoi
    end

  end

end
