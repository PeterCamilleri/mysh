# coding: utf-8

#* mysh/internal/actions/comment.rb -- A mysh internal comment.
module Mysh

  #* mysh/internal/actions/comment.rb -- A mysh internal comment.
  class MyshComment < Action

    #Ignore a comment.
    def process_command(_args)
      :internal
    end

  end

  #Add comments to the library.
  desc = 'A mysh comment. No action taken'
  MYSH_COMMENT = MyshComment.new('#<stuff>', desc)
  COMMANDS.add_action(MYSH_COMMENT)
end
