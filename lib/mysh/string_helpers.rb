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

  # Make the file name fit the local system.
  def to_host_spec
    self.dress_up_slashes
        .dress_up_quotes
  end

  # Dress up slashes and backslashes.
  def dress_up_slashes
    MiniTerm.windows? ? self.gsub("/", "\\") : self
  end

  # Dress up in quotes if needed.
  def dress_up_quotes
    self[' '] ? "\"#{self}\"" : self
  end

  # Make the file name fit the standard notation.
  def to_std_spec
    self.gsub("\\", "/")
  end

end
