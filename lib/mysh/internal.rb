# coding: utf-8

#* internal.rb -- mysh internal command support.
module Mysh

  #A mysh internal command.
  class InternalCommand

    @commands = {}

    #Add a command to the command library.
    def self.add(command)
      @commands[command.name] = command
    end

    #Execute an internal command
    def self.execute(str)
      args = str.split

      if (command = @commands[args[0]])
        command.execute(args[1..-1])
        true
      else
        false
      end
    end

    #The name of the command.
    attr_reader :name

    #Setup an internal command
    def initialize(name, description, &action)
      @name        = name
      @description = description
      @action      = action
    end

    #Execute the command.
    def execute(args)
      @action.call(args)
    end

    #Get information about the command.
    def info
      [@name, @description]
    end

  end


end

#Load up the commands!
Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }

