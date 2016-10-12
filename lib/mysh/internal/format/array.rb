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
  def format_mysh_columns(page_width = Mysh::PAGE_WIDTH)
    builder = Mysh::ColumnizedPage.new(Mysh::PAGE_LENGTH, page_width)

    self.each {|item| builder.add(item)}

    builder.render
  end

  alias :format_description :format_mysh_columns

  #Get the widest element of an array.
  #<br>Returns
  #* The width of the widest string in the array.
  def mysh_column_width
    (self.max_by {|item| item.length}).length
  end


  # Bullets ========================================================

  #Print out the array as bullet points.
  def puts_mysh_bullets
    puts mysh_bulletize
  end

  #Convert the array to strings with bullet points.
  #<br>
  #* An array of strings
  def mysh_bulletize(page_width = Mysh::PAGE_WIDTH)
    builder = Mysh::BulletPoints.new(page_width)

    self.each do |pair|
      builder.add(*pair)
    end

    builder.render
  end

end

