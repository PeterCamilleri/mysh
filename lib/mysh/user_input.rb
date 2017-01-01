# coding: utf-8

require 'mini_readline'

require_relative 'sources/console'

require_relative 'sources/smart_auto_complete'
require_relative 'sources/parse'

#* mysh/user_input.rb -- Get some text from the user.
module Mysh

  #Get one command from the user.
  def self.get_command(source)
    get_command_extra(source, source.get_command)
  end

  #Get any continuations of the inputs
  def self.get_command_extra(source, str)
    if /\\\s*$/ =~ str
      get_command_extra(source, $PREMATCH + "\n" + source.get_command_extra(str))
    else
      str
    end
  end

  #Get the user input ready.
  def self.input
    @input ||= MiniReadline::Readline.new(history:       true,
                                          eoi_detect:    true,
                                          auto_complete: true,
                                          auto_source:   SmartSource)
  end

end

