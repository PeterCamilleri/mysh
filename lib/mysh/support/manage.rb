# coding: utf-8

#* support/manage.rb -- Manage mysh internal commands.
module Mysh

  #The mysh internal command class level data and methods.
  class InternalCommand

    #Set up the command library hash.
    @commands = {}

    class << self
      #The command library, a hash.
      attr_reader :commands
    end

    #Add a command to the command library.
    def self.add(name, description, &action)
      @commands[name.split[0]] = new(name, description, &action)
    end

    #Add an alias for an existing command.
    def self.add_alias(new_name, old_name)
      unless (command = @commands[old_name])
        fail "Error adding alias #{new_name} for #{old_name}"
      end

      @commands[new_name] = new(new_name.split[0],
                                command.description,
                                &command.action)
    end

    #Execute an internal command
    def self.execute(str)
      unless str[0] == ' '
        command, args = parse(str.chomp)

        if (command)
          command.execute(args)
          :internal
        end
      end
    end

    #Get information on all commands.
    def self.info
      @commands
        .values
        .map  {|command| command.info }
        .sort {|first, second | first[0] <=> second[0] }
    end

    #Display an array of items.
    def self.display_items(items)
      #Determine the width of the tag area.
      tag_width = items.max_by {|item| item[0].length}[0].length + 1

      #Display the information.
      items.each {|item| display_item(item, tag_width) }

      puts
    end

    #Display one item.
    def self.display_item(item, tag_width=nil)
      tag = item[0]
      tag_width ||= tag.length + 1

      item[1].each do |detail|
        puts "#{tag.ljust(tag_width)} #{detail}"
        tag = ""
      end
    end

  end
end

