# coding: utf-8

#* mysh/init.rb -- The mysh init file loader.
module Mysh

  #Set the init file used to startup mysh to none so far.
  $mysh_init_file = nil

  #Perform init phase processing.
  def self.mysh_load_init

    unless $mysh_init_file || !(home = ENV['HOME'])
      name_mysh = home + '/mysh_init.mysh'
      name_rb = home + '/mysh_init.rb'

      if File.file?(name_mysh)
        process_file($mysh_init_file = name_mysh)
      elsif File.file?(name_rb)
        load ($mysh_init_file = name_rb)
      end
    end

    $mysh_init_file = '<none found>' unless $mysh_init_file
  end

end
