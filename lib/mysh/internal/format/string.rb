# coding: utf-8

#* internal/format/string.rb - Support for displaying data formatted neatly.
class String

  #Create a bullet point description from this string.
  #<br>Returns
  #* An array of strings.
  def format_description(max_width)
    do_format_description(split(' ').each, max_width)
  end

  #Do the formatting legwork.
  #<br>Returns
  #* An array of strings.
  def do_format_description(input, max_width)
    buffer, build, empty = [], "", false

    loop do  #Grab "words" of input, splitting off lines as needed.
      empty = (build = build.split_if_over(input.next, max_width, buffer)
                            .split_if_huge(max_width, buffer)).empty?
    end

    unless empty
      buffer << build
    end

    buffer
  end

  #Split if adding a word goes over a little.
  #<br>Returns
  #* A string.
  def split_if_over(word, max_width, buffer)
    word.prepend(" ") unless empty? #Add a space except for the first word.

    word_len = word.length

    if (length + word_len) >= max_width && word_len < max_width
      buffer << self  #Line done, add to buffer.
      word.lstrip     #Start of a new line, remove the leading space.
    else
      self + word
    end
  end

  #Split up a overlong blob of text.
  #<br>Returns
  #* A string.
  def split_if_huge(max_width, buffer)

    #Slice away any excess text into lines in the buffer.
    while length >= max_width
      buffer << slice!(0, max_width)
    end

    self
  end
end

