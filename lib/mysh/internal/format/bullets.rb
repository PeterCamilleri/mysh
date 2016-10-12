# coding: utf-8

#* internal/format/bullets.rb - Print out bullet points.
module Mysh

  #A class to display data in bullet points.
  class BulletPoints

    #Prepare a blank slate.
    def initialize(page_width)
      @page_width  = page_width
      @bullet_data = []
    end

    #Add an item to this page.
    #<br>Endemic Code Smells
    #* :re ek:FeatureEnvy  :re ek:TooManyStatements
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
    #* :re ek:DuplicateMethodCall :re ek:TooManyStatements
    def render_bullet(key, item)
      result   = []
      input    = item.split(' ').each
      temp     = key.ljust(len = @key_length)
      desc_len = @page_width - @key_length - 1

      loop do

        word_len = (word = ' ' + input.next).length

        if (len += word_len) >= @page_width && word_len < desc_len
          result << temp
          temp = blank_key + word
          len  = temp.length
        else
          temp << word
        end

        while len >= @page_width
          result << temp.slice!(0, @page_width - 1)
          temp = blank_key + ' ' + temp
          len  = temp.length
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

