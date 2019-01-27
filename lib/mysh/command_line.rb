# coding: utf-8

# The mysh internal command line option.
module Mysh

  # Action pool of command line options.
  COMMAND_LINE = ActionPool.new("COMMAND_LINE")

  # The mysh internal command line option.
  class CommandOption < Action

    # Execute a pre-boot command line option.
    def pre_boot(_args); end

    # Execute a post-boot command line option.
    def post_boot(_args); end

    alias :process_command :pre_boot

    # Get an argument for an option.
    def get_arg(read_point)
      result = read_point.next
      fail if COMMAND_LINE.exists?(result) #An arg should not be a command!
      result
    rescue
      fail "Error in #{short_name.inspect}: Invalid argument: #{result.inspect}"
    end

  end

  # Execute command line options.
  #<Endemic Code Smells   :reek:TooManyStatements
  def self.process_command_args(args, phase)
    read_point = args.each

    loop do
      next_option = read_point.next
      next_command = COMMAND_LINE[next_option]
      raise "Error: Invalid option #{next_option.inspect}" unless next_command
      next_command.send(phase, read_point)
    end

  rescue MyshUsage
    HELP["usage"].process_command(nil)
    exit

  rescue => err
    more(MNV) do
      puts "", err.to_s, ""
      HELP["usage"].process_command(nil)
    end

    exit
  end

end

# Load up the extra help actions!
path = MYSH_LIB + "mysh/command_line/*.rb"
Dir[path].each {|file| require file }
