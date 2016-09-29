# coding: utf-8

#* commands/exit.rb -- The mysh internal exit command.
module Mysh

  #* exit.rb -- The mysh internal exit command.
  class InternalCommand
    #Show a help file
    def show_help(name)
      full_name = File.dirname(__FILE__) + name
      str = IO.read(full_name)
      puts process_erb_string(str)
    rescue StandardError, ScriptError => err
      puts "Error processing file #{full_name}"
      puts "#{err.class.to_s}: #{err}"
    end

    HELP = Hash.new(lambda {|args| puts "No help found for #{args[0]}." })

    HELP[nil]    = lambda {|_args| show_help('/help.txt') }
    HELP['math'] = lambda {|_args| show_help('/help_math.txt') }
    HELP['ruby'] = lambda {|_args| show_help('/help_ruby.txt') }

    #Add the exit command to the library.
    add('help', 'Display help information for mysh.') do |args|
      instance_exec(args, &HELP[args[0]])
    end

    add_alias('?', 'help')

  end

end

