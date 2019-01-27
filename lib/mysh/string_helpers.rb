# coding: utf-8

# Monkey patches for Mysh string data.
class String

  # Extract common mysh data from this string.
  def extract_boolean
    if self =~ /\A(false|no|off)\z/i
      false
    else
      self
    end
  end

end
