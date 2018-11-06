# coding: utf-8

#* mysh/internal/to_host_spec.rb -- mysh internal file name beauty treatments.
class String

  #Make the file name fit the local system.
  def to_host_spec
    self.dress_up_slashes
        .dress_up_quotes
  end

  #Dress up slashes and backslashes.
  def dress_up_slashes
    MiniTerm.windows? self.gsub("/", "\\") : self
  end

  #Dress up in quotes if needed.
  def dress_up_quotes
    self[' '] ? "\"#{self}\"" : self
  end

  #Make the file name fit the standard notation.
  def to_std_spec
    self.gsub("\\", "/")
  end
end
