# coding: utf-8

#* internal/format/string.rb - Support for displaying data formatted neatly.
class String

  #Create a bullet point description from this string.
  def format_description(max_width)
    input, build, len, result = split(' ').each, "", 0, []

    loop do
      word_len = (word = (build.empty? ? "" : " ") + input.next).length

      if (len += word_len) >= max_width && word_len < max_width
        result << build
        build, len = word[1..-1], word_len-1
      else
        build << word
      end

      len = build.split_if_huge(max_width, result).length
    end

    result << build
  end

  def split_if_over(word, max_width, buffer)
    word_len = word.length

    if (length + word_len) >= max_width && word_len < max_width
      result << build
      build, len = word[1..-1], word_len-1
    else
      build << word
    end

  end

  #Carve up a overlong line of text.
  def split_if_huge(max_width, buffer)
    while length >= max_width
      buffer << slice!(0, max_width)
    end

    self
  end
end

