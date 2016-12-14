# coding: utf-8

require_relative 'shell_variables/shell_variable_commands'
require_relative 'shell_variables/shell_variable_store'
require_relative 'shell_variables/shell_variable_value'
require_relative 'shell_variables/object'
require_relative 'shell_variables/string'

#* mysh/shell_variables.rb -- Adds support for mysh scripting variables.
module Mysh

  #Set up some essential entries.
  MNV[:$$] = "$"


end
