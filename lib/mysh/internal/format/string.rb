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
    result, build = [], ""

    #Grab "words" of input, splitting off lines as needed.
    loop do
      build = build.split_if_over(input.next, max_width, result)
                   .split_if_huge(max_width, result)
    end

    #Return the accumulated lines of text plus a last line of "unclaimed" text.
    result << build
  end

  #Split if adding a word goes over a little.
  #<br>Returns
  #* A string.
  def split_if_over(word, max_width, buffer)

    #Add a space separator unless this is the first word in the line.
    word.prepend(" ") unless empty?

    word_len = word.length

    if (length + word_len) >= max_width && word_len < max_width
      buffer << self

      #Since we start a new line, remove the space.
      word.lstrip
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

    #Return the remaining text that's not too long.
    self
  end
end

