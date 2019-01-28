# coding: utf-8

module Mysh

  # Set up the command action pool.
  COMMANDS = ActionPool.new("COMMANDS")

  # Try to execute the string as an internal action.
  def self.try_execute_internal(input)
    unless input.quick_command == ' '
      if (action = COMMANDS[input.raw_command])
        action.process_command(input)
        :internal
      end
    end
  end

end

# Load up the internal actions!
load_spec = MYSH_LIB + "mysh/internal/*.rb"
Dir[load_spec].each {|file| require file }
