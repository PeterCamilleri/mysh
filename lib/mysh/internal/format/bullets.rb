# coding: utf-8

#* internal/format/bullets.rb - Print out bullet points.
module Mysh

  #A class to display data in bullet points.
  class BulletPoints

    PAGE_WIDTH = 80

    #Prepare a blank slate.
    def initialize
      @bullet_data = []
    end

    #Add an item to this page.
    #<br>Endemic Code Smells
    #* :reek:FeatureEnvy  :reek:TooManyStatements
    def add(raw_bullet = "*", *raw_item)

      if raw_item.empty?
        bullet = ["*"]
        items = raw_bullet.in_array
      else
        bullet = [raw_bullet]
        items = raw_item.in_array
      end

      items.each_index do |index|
        @bullet_data << [(bullet[index] || "").to_s, items[index].to_s]
      end
    end

    #Render the page as an array of strings.
    def render
      @key_length, results = get_key_length, []

      @bullet_data.each do |key, item|
        results.concat(render_bullet(key, item))
      end

      @bullet_data = []
      results
    end

    private

    #How large is the largest bullet?
    def get_key_length
      (@bullet_data.max_by {|line| line[0].length})[0].length
    end

    #Render one bullet point.
    #<br>Endemic Code Smells
    #* :reek:DuplicateMethodCall :reek:TooManyStatements
    def render_bullet(key, item)
      result, pass_one = [], true
      input  = item.split(' ').each
      temp   = key.ljust(len = @key_length)

      loop do
        word = ' ' + input.next

        while len >= PAGE_WIDTH
          result << temp.slice!(0, PAGE_WIDTH - 1)
          temp = blank_key + ' ' + temp
          len  = temp.length
        end

        if ((len += word.length) >= PAGE_WIDTH) && !pass_one
          result << temp
          temp = blank_key + word
          len  = temp.length
        else
          temp << word
          pass_one = false
        end
      end

      result << temp
    end

    #Generate a blank bullet key
    def blank_key
      ' ' * @key_length
    end

  end

end

#Bullet point support in the Array class.
class Array
  #Print out the array as bullet points.
  def puts_mysh_bullets
    puts mysh_bulletize
  end

  #Convert the array to strings with bullet points.
  #<br>
  #* An array of arrays of strings
  def mysh_bulletize
    builder = Mysh::BulletPoints.new

    self.each do |pair|
      builder.add(*pair)
    end

    builder.render
  end
end

