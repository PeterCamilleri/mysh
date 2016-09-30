# coding: utf-8

#* support/format.rb -- Format mysh internal reports.
module Mysh

  #The mysh internal command class level report formatting.
  class InternalCommand

    #Get information on all commands.
    def self.command_info(source=COMMANDS)
      source
        .values
        .map  {|command| command.command_info }
        .sort {|first, second| first[0] <=> second[0] }
    end

    #Display an array of items.
    def display_items(items)
      puts format_items(items)
      puts
    end

    #Format an array of items.
    #<br>Endemic Code Smells
    #* :reek:FeatureEnvy
    def format_items(items, buffer=[])
      #Determine the width of the tag area.
      tag_width = items.max_by {|item| item[0].length}[0].length + 1

      #Display the information.
      items.each {|item| format_item(item, buffer, tag_width) }

      buffer
    end

    #Display one item.
    def display_item(item, tag_width=nil)
      puts format_item(item, [], tag_width)
      puts
    end

    #Format one item.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def format_item(item, buffer=[], tag_width)
      tag = item[0]

      item[1].each do |detail|
        buffer << "#{tag.ljust(tag_width)} #{detail}"
        tag = ""
      end

      buffer
    end

  end
end

