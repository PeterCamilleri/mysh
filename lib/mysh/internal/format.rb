# coding: utf-8

require_relative 'format/bullets'

#The mysh internal command class level report formatting.
class Object

  private

  #Display an array of items.
  def display_items(items)
    items.puts_mysh_bullets
    puts
  end

  #Format an array of items.
  #<br>Endemic Code Smells
  #* :reek:FeatureEnvy :reek:UtilityFunction
  def format_items(items)
    items.mysh_bulletize
  end

end

