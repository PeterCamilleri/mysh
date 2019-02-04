# coding: utf-8

# mysh -- MY SHell -- a Ruby inspired command line shell.

require 'pp'
require 'English'
require 'in_array'
require 'insouciant'
require 'pause_output'
require 'format_output'
require 'mini_readline'

# The path to the gem lib folder.
MYSH_LIB = (File.expand_path(File.dirname(__FILE__)) + "/").freeze

require_relative 'mysh/exceptions'
require_relative 'mysh/string_helpers'
require_relative 'mysh/input_wrapper'
require_relative 'mysh/user_input'
require_relative 'mysh/action'
require_relative 'mysh/action_pool'
require_relative 'mysh/internal'
require_relative 'mysh/quick'
require_relative 'mysh/external'
require_relative 'mysh/command_line'
require_relative 'mysh/system'
require_relative 'mysh/handlebars'
require_relative 'mysh/shell_variables'
require_relative 'mysh/process'
require_relative 'mysh/globalize'
require_relative 'mysh/load_init_file'
require_relative 'mysh/expression'
require_relative 'mysh/version'

# The Mysh (MY SHell) module.
module Mysh

  # The actual shell method.
  def self.run(args=[])
    process_command_args(args, :pre_boot)
    mysh_load_init
    process_command_args(args, :post_boot)

    process_console
  end

  reset_host
end

if __FILE__ == $0
  Mysh.run(ARGV)  # Run a shell if this file is run directly.
end

# Suppress an annoying warning during tests.
$VERBOSE = nil if defined?(Rake)
