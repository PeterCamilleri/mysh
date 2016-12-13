# coding: utf-8

#* mysh/internal/decorate.rb -- mysh internal file name beauty treatments.
class String

  #Make the file name fit the local system.
  def decorate
    dress_up_slashes.dress_up_quotes
  end

  #Dress up slashes and backslashes.
  def dress_up_slashes
    backslash? ? self.gsub("/", "\\") : self
  end

  #Dress up in quotes if needed.
  def dress_up_quotes
    self[' '] ? "\"#{self}\"" : self
  end

  #Does this file name use backslashes?
  #<br>Endemic Code Smells
  #* :reek:UtilityFunction
  def backslash?
    MiniReadline::PLATFORM == :windows
  end

end
