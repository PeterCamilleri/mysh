# coding: utf-8

require 'mini_readline'

require_relative 'user_input/smart_source'
require_relative 'user_input/parse'

#* mysh/user_input.rb -- Get some text from the user.
module Mysh

  class << self
    #The input text source.
    attr_reader :input
  end

  #Get one command from the user.
  #<br>Endemic Code Smells
  #* :reek:TooManyStatements
  def self.get_command
    puts MNV[:pre_prompt] if MNV.key?(:pre_prompt)

    initial_input = @input.readline(prompt: MNV[:prompt] + '>')
    @input.instance_options[:initial] = ""
    get_command_extra(initial_input)

  rescue MiniReadlineEOI
    @mysh_running = false
    "\n"
  end

  private

  #Get any continuations of the inputs
  def self.get_command_extra(str)
    if /\\\s*$/ =~ str
      parms = {prompt: MNV[:post_prompt] + '\\', prefix: str[0] }
      get_command_extra($PREMATCH + "\n" + @input.readline(parms))
    else
      str
    end

  end

  #Get the user input ready.
  def self.init_input
    @input = MiniReadline::Readline.new(history:       true,
                                        eoi_detect:    true,
                                        auto_complete: true,
                                        auto_source:   SmartSource)
  end

end

