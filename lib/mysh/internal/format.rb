# coding: utf-8

#* internal/format.rb - Some formatting facilities for mysh.
module Mysh

  #Assume an 80 column working area for formatting.
  PAGE_WIDTH = 80

end

require_relative 'format/bullets'
require_relative 'format/columns'
require_relative 'format/array'
require_relative 'format/string'
require_relative 'format/object'
require_relative 'format/nil'

