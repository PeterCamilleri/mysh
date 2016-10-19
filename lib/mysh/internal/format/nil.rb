# coding: utf-8

#* internal/format/nil.rb - Support for displaying nothing formatted neatly.
class NilClass

  #Create a bullet point description from nothing.
  def format_description(_max_width)
    []
  end

end


