# coding: utf-8

# Monkey patches for Mysh variables
class String

  # Evaluate any variable substitutions in the string.
  def eval_variables
    self.gsub(/((?<!\\)\$\$)|((?<!\\)\$[a-z][a-z0-9_]*)/) do |str|
      sym = str[1..-1].to_sym
      MNV.key?(sym) ? MNV[sym].to_s : str
    end.gsub(/\\\$/, "$")

  end

end
