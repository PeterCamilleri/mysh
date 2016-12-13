# coding: utf-8

#* mysh/internal/decorate.rb -- mysh internal file name beauty treatments.
module Mysh

  #Make the file name fit the local system.
  def self.decorate(name)
    dress_up_quotes(dress_up_slashes(name))
  end

  private

  #Dress up slashes and backslashes.
  def self.dress_up_slashes(name)
    backslash? ? name.gsub("/", "\\") : name
  end

  #Dress up in quotes if needed.
  #<br>Endemic Code Smells
  #* :reek:UtilityFunction
  def self.dress_up_quotes(name)
    name[' '] ? "\"#{name}\"" : name
  end

  #Does this file name use backslashes?
  #<br>Endemic Code Smells
  #* :reek:UtilityFunction
  def self.backslash?
    MiniReadline::PLATFORM == :windows
  end

end
