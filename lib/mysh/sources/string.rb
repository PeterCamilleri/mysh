# coding: utf-8

#* mysh/sources/string.rb -- The mysh string command source.
module Mysh

  #A wrapper for a string with mysh commands.
  class StringSource

    #Setup the string source.
    def initialize(str)
      @eoi = false
      @read_pt = str.lines.each
    end

    #Get the initial line of command input.
    def get_command(_str="")
      @read_pt.next
    rescue StopIteration
      @eoi = true
      "\n"
    end

    #Set up an alias as these two are identical.
    alias :get_command_extra :get_command

    #Have we reached the end of input?
    def eoi?
      @eoi
    end

  end

end
