# coding: utf-8

# mysh -- MY SHell -- a Ruby/Rails inspired command line shell.

require 'English'
require 'in_array'

require_relative 'mysh/exceptions'
require_relative 'mysh/user_input'
require_relative 'mysh/quick'
require_relative 'mysh/expression'
require_relative 'mysh/internal'
require_relative 'mysh/external_ruby'
require_relative 'mysh/handlebars'
require_relative 'mysh/shell_variables'
require_relative 'mysh/pre_processor'
require_relative 'mysh/process'
require_relative 'mysh/globalize'

require_relative 'mysh/version'

#The Mysh (MY SHell) module. A container for mysh and its functionality.
module Mysh

  #The actual shell method.
  def self.run(args=[])
    process_command_args(args, :pre_boot)
    # to do --- booting!!!
    process_command_args(args, :post_boot)

    process_console
  end

  reset_host
end

if __FILE__ == $0
  Mysh.run(ARGV)  #Run a shell if this file is run directly.
end
