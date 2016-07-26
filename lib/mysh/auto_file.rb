# coding: utf-8

#* auto_file.rb - The data source for mysh file name auto-complete.
module Mysh

  #* auto_file.rb - The data source for mysh file name auto-complete.
  class AutoFile

    #Create a new file/folder auto-data source. NOP
    def initialize(_options); end

    #Construct a new data list for auto-complete
    def rebuild(str)
      extract_root_pivot(str)

      list = Dir.glob(dress_down(@pivot) + '*')

      @cycler = list.empty? ? nil : list.cycle
    end

    #Parse the string into the two basic components.
    def extract_root_pivot(str)
      @root, @pivot = /\S+$/ =~ str ? [$PREMATCH, $MATCH] : [str, ""]
    end

    #Get the next string for auto-complete
    def next
      @root + dress_up(@cycler.next)
    end

    #Prepare the file name for internal use.
    def dress_down(name)
      name.gsub("\\", "/")
    end

    #Prepare the file name for external use.
    def dress_up(name)
      backslash? ? name.gsub("/", "\\") : name
    end

    #Does this file name use backslashes?
    def backslash?
      if @pivot.end_with?("\\")
        true
      elsif @pivot.end_with?("/")
        false
      elsif @pivot["\\"]
        true
      elsif @pivot["/"]
        false
      elsif MiniReadline::PLATFORM == :windows
        true
      else
        false
      end
    end

  end

end
