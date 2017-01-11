# coding: utf-8

#* mysh/internal/actions/command_line.rb -- The mysh internal command line option.
module Mysh

  # Action pool of command line options.
  COMMAND_LINE = ActionPool.new("COMMAND_LINE")

  #* mysh/internal/actions/command_line.rb -- The mysh internal command line option.
  class CommandOption < Action

    #Execute a pre-boot command line option.
    def pre_boot(_args); end

    #Execute a post-boot command line option.
    def post_boot(_args); end

    alias :call :pre_boot
  end

  #Execute command line options.
  def self.process_command_args(args, phase)
    read_point = args.each

    loop do
      next_option = read_point.next
      next_command = COMMAND_LINE[next_option]
      raise "Error: Invalid option #{next_option.inspect}" unless next_command
      next_command.send(phase, read_point)
    end

  rescue => err
    unless (msg = err.to_s).empty?
      puts "", msg, ""
    end

    HELP["usage"].call([])
    exit
  end

end

#Load up the extra help actions!
Dir[Mysh::Action::ACTIONS_PATH + 'command_line/*.rb'].each {|file| require file }
