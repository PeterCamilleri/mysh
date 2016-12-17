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

  #A regular expression for parsing embedded variables.
  MYSH_VARIABLE_PARSE = /(\$\$)|(\$[a-z][a-z0-9_]*)(?=[^a-z0-9_]|$)/

  #Evaluate any variable substitutions in the input.
  def eval_variables
    self.gsub(MYSH_VARIABLE_PARSE) do |str|
      sym = str[1..-1].to_sym
      MNV.key?(sym) ? MNV[sym].to_s : str
    end
  end

end
