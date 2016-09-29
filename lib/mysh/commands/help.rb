# coding: utf-8

#* commands/help.rb -- The mysh internal help command.
module Mysh

  #* help.rb -- The mysh internal help command.
  class InternalCommand

    HELP = Hash.new(lambda {|args| puts "No help found for #{args[0]}." })

    HELP[nil]    = lambda {|_args| show_file('help.txt') }
    HELP['math'] = lambda {|_args| show_file('help_math.txt') }
    HELP['ruby'] = lambda {|_args| show_file('help_ruby.txt') }

    #Add the exit command to the library.
    add('help', 'Display help information for mysh.') do |args|
      instance_exec(args, &HELP[args[0]])
    end

    add_alias('?', 'help')

  end

end

