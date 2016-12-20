# coding: utf-8

require_relative 'shell_variables/shell_variable_store'
require_relative 'shell_variables/shell_variable_keeper'
require_relative 'shell_variables/object'
require_relative 'shell_variables/string'

#* mysh/shell_variables.rb -- Adds support for mysh scripting variables.
module Mysh

  #Set up some essential entries.
  MNV['$'.to_sym] = "$"

  #Set up some default values.
  MNV[:debug]      = "false"
  MNV[:prompt]     = "mysh"
  MNV[:pre_prompt] = "$w"

  MNV[:d] = "{{ Time.now.strftime(MNV[:date_fmt]) }}"
  MNV[:h] = "{{ ENV['HOME'].decorate }}"
  MNV[:t] = "{{ Time.now.strftime(MNV[:time_fmt]) }}"
  MNV[:u] = "{{ ENV['USER'] }}"
  MNV[:w] = "{{ Dir.pwd.decorate }}"

  MNV[:date_fmt] = "%Y-%m-%d"
  MNV[:time_fmt] = "%H:%M"

end
