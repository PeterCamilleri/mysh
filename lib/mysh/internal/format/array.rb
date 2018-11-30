# coding: utf-8

#* internal/format/array.rb - Support for displaying an array formatted neatly.
class Array

  # Columns ========================================================

  #Print out the array with efficient columns.
  def puts_mysh_columns(page_width  = MiniTerm.width)
    puts format_mysh_columns(page_width)
  end

  #Convert the array to strings with efficient columns.
  #<br>Returns
  #* An array of strings.
  #<br>Endemic Code Smells
  #* :reek:FeatureEnvy -- false positive.
  def raw_mysh_columns(page_width)
    builder = Mysh::ColumnizedPage.new(page_width)

    each {|item| builder.add(item)}

    builder.render
  end

  alias :format_description :raw_mysh_columns

  #Convert the array to strings with efficient columns.
  #<br>Returns
  #* A string.
  #<br>Endemic Code Smells
  #* :reek:FeatureEnvy -- false positive.
  def format_mysh_columns(page_width = MiniTerm.width)
    raw_mysh_columns(page_width).join("\n")
  end

  #Get the widest element of an array.
  #<br>Returns
  #* The width of the widest string in the array.
  def mysh_column_width
    max_by {|item| item.length}.length
  end


  # Bullets ========================================================

  #Print out the array as bullet points.
  def puts_mysh_bullets(page_width = MiniTerm.width)
    puts format_mysh_bullets(page_width)
  end

  #Convert the array to strings with bullet points.
  #<br>Returns
  #* A string.
  #<br>Endemic Code Smells
  #* :reek:FeatureEnvy -- false positive.
  def format_mysh_bullets(page_width = MiniTerm.width)
    return "" if empty?

    builder = Mysh::BulletPoints.new(page_width)

    each {|pair| builder.add(*pair.prepare_bullet_data)}

    builder.render.join("\n")
  end

  #Get data ready for being in a bullet point.
  def prepare_bullet_data
    if length < 2
      ["*", self[0]]
    else
      self
    end
  end

end

