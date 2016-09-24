# coding: utf-8

#* support/format.rb -- Format mysh internal reports.
module Mysh

  #The mysh internal command class level report formatting.
  class InternalCommand

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
