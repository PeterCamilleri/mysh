# coding: utf-8

#* mysh/internal/actions/type.rb -- The mysh type command.
module Mysh

  #Add the type command to the library.
  desc = 'Display one or more text files with optional support for ' +
         'embedded handlebars and shell variables. See ?type for more.'

  action = lambda do |input|
    count = 0
    cooked = MNV[:type] !~ /\A(raw|false|no|off)\z/i
    args = input.args

    args.each do |file_name|
      puts file_name if args.length > 1

      case file_name
      when "-c"
        cooked = false
      when "+c"
        cooked = true
      else
        if cooked
          show_handlebar_file(file_name, binding)
        else
          puts IO.read(file_name)
        end
      end

      count += 1
    end

    fail "A text file must be specified." if count == 0
  end

  COMMANDS.add_action(Action.new('type <files>', desc, &action))
end
