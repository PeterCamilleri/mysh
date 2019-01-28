# coding: utf-8

#* mysh/internal/actions/load.rb -- The mysh load command.
module Mysh

  #Add the load command to the library.
  desc = "Load ruby programs, mysh scripts, " +
         "or text files into the mysh environment."

  action = lambda do |input|
    count = 0
    args = input.args

    args.each do |file_name|
      puts file_name if args.length > 1
      Mysh.load_a_file(file_name)
      count += 1
    end

    if count > 0
      :internal
    else
      fail "Error: A load file must be specified."
    end
  end

  # Load a single file.
  def self.load_a_file(file_name)
    case File.extname(file_name)
    when '.mysh'
      Mysh.process_file(file_name)
      :internal
    when '.txt'
      show_handlebar_file(file_name, binding)
      :internal
    when '.rb'
      load file_name
      :internal
    else
      fail "Error: Unknown file type: #{file_name.inspect}"
    end
  end

  COMMANDS.add_action(Action.new('load <files>', desc, &action))
end
