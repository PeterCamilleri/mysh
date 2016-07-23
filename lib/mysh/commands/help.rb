# coding: utf-8

#* commands/exit.rb -- The mysh internal exit command.
module Mysh

  #* exit.rb -- The mysh internal exit command.
  class InternalCommand
    #The tag used for default external help.
    EXT_TAG = '-'

    #Add the exit command to the library.
    add(self.new('help', 'Display help information for mysh.') do |args|
      puts "mysh (MY SHell) version: #{Mysh::VERSION}"
      puts

      if args.empty?
        width = 0
        puts "Internal mysh commands:"
        puts " - executed by mysh directly."
        puts " - a leading space skips all internal commands."
        puts

        InternalCommand
          .info
          .concat(ExecHost.info)
          .sort do |first, second |
            width = [width, first[0].length, second[0].length].max
            first[0] <=> second[0]
          end
          .each do |info|
            puts "#{info[0].ljust(width)}    #{info[1]}"
          end

        puts
        puts "External commands:"
        puts " - executed by the system using the standard shell."
        puts " - use help #{EXT_TAG} for more info on external commands."
        puts
      else
        args[0] = "" if args[0] == EXT_TAG
        system("help " + args.join)
      end

    end)

    add_alias('?', 'help')
  end
end

