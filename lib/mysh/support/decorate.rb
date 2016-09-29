# coding: utf-8

#* support/decorate.rb -- mysh internal file name beauty treatments.
module Mysh

  #The mysh internal file name beauty treatments.
  class InternalCommand

    #Make the file name fit the local system.
    def decorate(name)
      dress_up_quotes(dress_up_slashes(name))
    end

    private

    #Dress up slashes and backslashes.
    def dress_up_slashes(name)
      backslash? ? name.gsub("/", "\\") : name
    end

    #Dress up in quotes if needed.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def dress_up_quotes(name)
      name[' '] ? "\"#{name}\"" : name
    end

    #Does this file name use backslashes?
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def backslash?
      MiniReadline::PLATFORM == :windows
    end

  end

end
