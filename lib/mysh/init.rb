# coding: utf-8

#* mysh/init.rb -- The mysh init file loader.
module Mysh

  #Set the init file used to startup mysh to none so far.
  $mysh_init_file = nil

  #Perform init phase processing.
  def self.mysh_load_init

    unless $mysh_init_file

      if (home = ENV['HOME'])
        name_mysh = home + '/mysh_init.mysh'
        name_rb   = home + '/mysh_init.rb'
        name_txt  = home + '/mysh_init.txt'

        $mysh_init_file = (File.file?(name_mysh) && name_mysh) ||
                          (File.file?(name_rb)   && name_rb)   ||
                          (File.file?(name_txt)  && name_txt)
      end

      if $mysh_init_file
        mysh "load #{$mysh_init_file.decorate}"
      else
        $mysh_init_file = '<none found>'
      end
    end

  end

end
