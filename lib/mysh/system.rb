# coding: utf-8

# Support for executing through the system.
module Mysh

  # Try to execute as a system program.
  def self.try_execute_system(input)
    system(input.raw.preprocess.chomp + "\n") ? :system : :error
  end

end
