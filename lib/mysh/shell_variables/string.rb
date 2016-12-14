# coding: utf-8

#Monkey patches for Mysh variables
class String

  #Extract common mysh data from this string.
  def extract_mysh_types
    if self =~ /true|yes|on/i
      true
    elsif self =~ /false|no|off/i
      false
    else
      self
    end
  end

end
