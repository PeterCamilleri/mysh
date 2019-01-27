# coding: utf-8

#* mysh/internal/actions/comment.rb -- A mysh internal comment.
module Mysh

  #Add comments to the library.
  desc = 'A mysh comment. No action taken'
  action = lambda {|_input| :internal}

  MYSH_COMMENT = Action.new('#<stuff>', desc, &action)
  COMMANDS.add_action(MYSH_COMMENT)
end
