# coding: utf-8

#* mysh/internal/actions/say.rb -- A mysh internal say command.
module Mysh

  #* mysh/internal/actions/say.rb -- A mysh internal say command.
  class SayCommand < Action

    #Say something!
    def call(args)
      puts args.join(' ')
      :internal
    end

  end

  #Add says to the library.
  desc = 'Display the text in the command arguments.'
  COMMANDS.add_action(SayCommand.new('say <stuff>', desc))
end
