# coding: utf-8

# The mysh initial file loader.
module Mysh

  # Set the initial file used to startup mysh to none so far.
  $mysh_init_file = nil

  # Perform initial phase processing.
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
