# coding: utf-8

require_relative 'internal/actions/actions_path'

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
Dir[Mysh::Action::ACTIONS_PATH + '*.rb'].each {|file| require file }
