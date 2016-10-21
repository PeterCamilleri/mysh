# coding: utf-8

require 'mini_readline'

require_relative 'user_input/smart_source'
require_relative 'user_input/parse'
require_relative 'user_input/handlebars'

#* mysh/user_input.rb -- Get some text from the user.
module Mysh

  class << self
    #The input text source.
    attr_reader :input
  end

  #Get one command from the user.
  def self.get_command(root="")
    initial_input = @input.readline(prompt: root + '>')
    @input.instance_options[:initial] = ""
    get_command_extra(initial_input, root)

  rescue MiniReadlineEOI
    (@mysh_running = nil).to_s
  end

  private

  #Get any continuations of the inputs
  def self.get_command_extra(str, root)
    if /\\\s*$/ =~ str
      parms = {prompt: root + '\\', prefix: str[0] }
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

