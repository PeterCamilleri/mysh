# coding: utf-8

#* mysh/internal/actions/elapsed.rb -- The mysh internal elapsed command.
module Mysh

  #Add the elapsed commands to the library.
  desc = 'Execute a command and then display the elapsed time.'

  action = lambda do |str|
    start_time = Time.now
    Mysh.try_execute_command(str[1..-1])
    end_time = Time.now

    puts "Elapsed execution time = #{"%.3f" % (end_time - start_time)} seconds."
    :internal
  end

  TIMED_COMMAND = Action.new('%<command>', desc, &action)
  COMMANDS.add_action(TIMED_COMMAND)
end
