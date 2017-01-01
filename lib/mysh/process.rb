# coding: utf-8

#* mysh/process.rb -- The mysh command processors.
module Mysh

  #Process from the console
  def self.process_console
    process_source(Console.new)
  end

  #Process commands from a source.
  def self.process_source(source)
    until source.eoi? do
      execute_a_command(get_command(source))
    end
  end

  #Execute a single line of input and handle exceptions.
  def self.execute_a_command(str)
    try_execute_command(str)

  rescue Interrupt, StandardError, ScriptError => err
    puts "Error #{err.class}: #{err}"
    puts err.backtrace if MNV[:debug]
  end

  #Try to execute a single line of input. Does not handle exceptions.
  def self.try_execute_command(input)
    unless input.start_with?("$")
      input = input.preprocess
    end

    puts "=> #{input}" if MNV[:debug]

    try_execute_quick_command(input)    ||
    try_execute_internal_command(input) ||
    try_execute_external_ruby(input)    ||
    system(input)
  end

end