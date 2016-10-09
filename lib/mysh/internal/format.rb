# coding: utf-8

#* internal/format.rb - Some formatting facilities for mysh.
module Mysh

  #Assume an 80 column working area for formatting.
  PAGE_WIDTH = 80

  #Assume an 80 column working area for formatting.
  PAGE_LENGTH = 55

end

require_relative 'format/bullets'
require_relative 'format/columns'
