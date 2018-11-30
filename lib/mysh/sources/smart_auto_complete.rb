# coding: utf-8

#* mysh/sources/smart_auto_complete.rb - An adaptive source for auto-complete.
module Mysh

  #* array_source.rb - An array as the source for auto-complete.
  class SmartSource

    #Create a new file/folder auto-data source. NOP
    def initialize(options)
      @prefix        = options[:prefix]
      @auto_source   = MiniReadline::AutoFileSource.new(options)
      @quote_source  = MiniReadline::QuotedFileFolderSource.new(options)
      @active_source = nil
    end

    #Construct a new data list for auto-complete
    def rebuild(str)
      if /(?<=\s|^)\$[a-z][a-z0-9_]*\z/ =~ str
        sym = $MATCH[1..-1].to_sym
        @active_source = nil
        return @str = $PREMATCH + MNV[sym] if MNV.key?(sym)
      end

      @active_source = (@prefix || str[0]) == '=' ? @quote_source : @auto_source
      @active_source.rebuild(str)
    end

    #Get the next string for auto-complete
    def next
      @active_source ? @active_source.next : @str
    end

  end

end
