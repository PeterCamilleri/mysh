# coding: utf-8

#* mysh/internal/actions/history.rb -- The mysh internal history command.
module Mysh

  #* mysh/internal/actions/history.rb -- The mysh internal history command.
  class HistoryCommand < Action

    #Set up this command.
    def initialize(*args)
      super
      @args = @history = nil
    end

    #Execute the history command.
    def process_command(input)
      @args, @history = input.args, Mysh.input.history

      #The history command should not be part of the history.
      @history.pop

      pull_index || clear_history || show_history
    end

    private

    #Deal with history index arguments
    def pull_index
      index = @args[0].to_i

      if (1..@history.length) === index
        Mysh.input.instance_options[:initial] = @history[index-1]
      else
        false
      end
    end

    #Clear the history buffer.
    def clear_history
      if @args[0] == 'clear'
        @history.clear
      else
        false
      end
    end

    #Just show the history.
    def show_history
      pattern = Regexp.new(@args[0] || /./)

      @history.each_with_index do |item, index|
        puts "#{index+1}: #{item}" if item =~ pattern
      end
    end

  end

  #Add the history commands to the library.
  desc = 'Display the mysh command history, or if an index is specified, ' +
         'retrieve the command with that index value.'
  COMMANDS.add_action(HistoryCommand.new('history <index>', desc))
  #The history command action object.
  HISTORY_COMMAND = HistoryCommand.new('!<index>', desc)
  COMMANDS.add_action(HISTORY_COMMAND)
end
