# coding: utf-8

#* mysh/internal/actions/elapsed.rb -- The mysh internal elapsed command.
module Mysh

  #* mysh/internal/actions/elapsed.rb -- The mysh internal elapsed command.
  class TimedCommand < Action

    #Execute the elapsed command.
    def call(str)
      start_time = Time.now
      Mysh.try_execute_command(str[1..-1])
      end_time = Time.now

      puts "Elapsed execution time = #{end_time - start_time} seconds."
      :internal
    end

  end

  #Add the elapsed commands to the library.
  desc = 'Execute a command and then display the elapsed time.'
  TIMED_COMMAND = TimedCommand.new('%<command>', desc)
  COMMANDS.add_action(TIMED_COMMAND)
end
