# coding: utf-8

#* array_source.rb - An array as the source for auto-complete.
module Mysh

  #* array_source.rb - An array as the source for auto-complete.
  class SmartSource

    #Create a new file/folder auto-data source. NOP
    def initialize(options)
      @prefix = options[:prefix]
      @auto_source = MiniReadline::AutoFileSource.new(options)
      @quote_source = MiniReadline::QuotedFileFolderSource.new(options)
    end

    #Construct a new data list for auto-complete
    def rebuild(str)
      @active_source = (@prefix || str[0]) == '=' ? @quote_source : @auto_source
      @active_source.rebuild(str)
    end

    #Get the next string for auto-complete
    def next
      @active_source.next
    end

  end

end
