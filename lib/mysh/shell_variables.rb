# coding: utf-8

require_relative 'shell_variables/shell_variable_store'
require_relative 'shell_variables/shell_variable_keeper'
require_relative 'shell_variables/evaluate'

#* mysh/shell_variables.rb -- Adds support for mysh scripting variables.
module Mysh

  #Set up some essential entries.
  MNV['$'.to_sym] = "$"

  #Set up some default values.
  MNV[:debug]       = "false"
  MNV[:prompt]      = "mysh>"
  MNV[:post_prompt] = "$prompt"
  MNV[:pre_prompt]  = "$w"

  MNV[:page_width]  = "{{ MiniTerm.width }}"
  MNV[:page_height] = "{{ MiniTerm.height }}"
  MNV[:page_pause]  = "on"

  MNV[:d] = "{{ Time.now.strftime(MNV[:date_fmt]) }}"
  MNV[:h] = "{{ ENV['HOME'].to_host_spec }}"
  MNV[:r] = "{{ RbConfig.ruby.to_host_spec }}"
  MNV[:s] = "{{ (ENV['SHELL'] || ENV['ComSpec'] || '').to_host_spec }}"
  MNV[:t] = "{{ Time.now.strftime(MNV[:time_fmt]) }}"
  MNV[:u] = "{{ ENV['USER'] }}"
  MNV[:w] = "{{ Dir.pwd.to_host_spec }}"

  MNV[:date_fmt] = "%Y-%m-%d"
  MNV[:time_fmt] = "%H:%M"
end
