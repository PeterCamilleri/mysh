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

  #Set up some default values.
  MNV[:$debug] = "false"
  MNV[:$pre_prompt] = "$w"

  MNV[:$d] = "{{ Time.now.strftime(\"$date_fmt\") }}"
  MNV[:$h] = "{{ ENV['HOME'] }}"
  MNV[:$t] = "{{ Time.now.strftime(\"$time_fmt\") }}"
  MNV[:$u] = "{{ ENV['USER'] }}"
  MNV[:$w] = "{{ Dir.pwd.decorate }}"

  MNV[:$date_fmt] = "%Y-%m-%d"
  MNV[:$time_fmt] = "%H:%M %z"

end
