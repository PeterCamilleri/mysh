# coding: utf-8

#* mysh/system.rb -- Support for executing through the system.
module Mysh

  #Try to execute as a system program.
  def self.try_execute_system(input)
    system(input.cooked) ? :system : :error
  end

end
