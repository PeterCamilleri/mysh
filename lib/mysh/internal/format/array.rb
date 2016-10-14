# coding: utf-8

#* internal/format/array.rb - Support for displaying an array formatted neatly.
class Array

  # Columns ========================================================

  #Print out the array with efficient columns.
  def puts_mysh_columns(page_width  = Mysh::PAGE_WIDTH)
    puts format_mysh_columns(page_width)
  end

  #Convert the array to strings with efficient columns.
  #<br>Returns
  #* An array of pages, that is, arrays of strings.
  #<br>Endemic Code Smells
  #* :reek:FeatureEnvy -- false positive.
  def format_mysh_columns(page_width = Mysh::PAGE_WIDTH)
    builder = Mysh::ColumnizedPage.new(Mysh::PAGE_LENGTH, page_width)

    each {|item| builder.add(item)}

    builder.render
  end

  alias :format_description :format_mysh_columns

  #Get the widest element of an array.
  #<br>Returns
  #* The width of the widest string in the array.
  def mysh_column_width
    max_by {|item| item.length}.length
  end


  # Bullets ========================================================

  #Print out the array as bullet points.
  def puts_mysh_bullets
    puts mysh_bulletize
  end

  #Convert the array to strings with bullet points.
  #<br>Returns
  #* An array of strings.
  #<br>Endemic Code Smells
  #* :reek:FeatureEnvy -- false positive.
  def mysh_bulletize(page_width = Mysh::PAGE_WIDTH)
    builder = Mysh::BulletPoints.new(page_width)

    each {|pair| builder.add(*pair)}

    builder.render
  end

end

