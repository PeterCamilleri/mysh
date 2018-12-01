# coding: utf-8

#* mysh/process.rb -- The mysh command processors.
module Mysh

  #Process from the console.
  def self.process_console
    process_source(Console.new)
  end

  #Process from a string.
  def self.process_string(str)
    process_source(StringSource.new(str))
  end

  #Process from a file.
  def self.process_file(name)
    process_source(StringSource.new(IO.read(name)))
  end

  #Process commands from a source.
  def self.process_source(source)
    until source.eoi? do
      execute_a_command(source)
    end
  rescue MyshExit
  end

  #Execute a single line of input and handle exceptions.
  def self.execute_a_command(source)
    try_execute_command(get_command(source))

  rescue MyshExit
    raise
  rescue Interrupt, StandardError, ScriptError => err
    puts "Error #{err.class}: #{err}"
    puts err.backtrace if MNV[:debug].extract_mysh_types || defined?(MiniTest)
  end

  #Try to execute a single line of input. Does not handle exceptions.
  def self.try_execute_command(str)
    input = InputWrapper.new(str)

    more do
      try_execute_quick(input)    ||
      try_execute_internal(input) ||
      try_execute_external(input) ||
      try_execute_system(input)
    end
  end

end
