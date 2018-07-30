# coding: utf-8

#* mysh/init.rb -- The mysh init file loader.
module Mysh

  #Set the init file used to startup mysh to none so far.
  $mysh_init_file = nil

  #Perform init phase processing.
  def self.mysh_load_init

    unless $mysh_init_file

      if (home = ENV['HOME'])
        names = [home + '/mysh_init.mysh',
                 home + '/mysh_init.rb',
                 home + '/mysh_init.txt']

        $mysh_init_file = names.detect {|name| File.file?(name)}
      end

      if $mysh_init_file
        mysh "load #{$mysh_init_file.to_host_spec}"
      else
        $mysh_init_file = '<none found>'
      end
    end

  end

end
