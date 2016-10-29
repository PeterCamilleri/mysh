# coding: utf-8

#* mysh/internal/actions/show/env.rb -- Get help on the mysh environment.
module Mysh

  #* mysh/internal/actions/show/env.rb -- Get help on the mysh environment.
  class EnvInfoCommand < Action

    #Execute the ? shell command.
    def call(_args)
      puts "Key mysh environment information.", ""
      puts info.mysh_bulletize, "",
           path.mysh_bulletize, ""
    end

    private

    #Get the info
    def info
      [["user",     ENV['USER']],
       ["home",     ENV['HOME']],
       ["name",     decorate($PROGRAM_NAME)],
       ["shell",    ENV['SHELL']    || ENV['ComSpec']],
       ["host",     ENV['HOSTNAME'] || ENV['COMPUTERNAME']],
       ["os",       ENV['OS']],
       ["platform", MiniReadline::TERM_PLATFORM],
       ["java",     MiniReadline::TERM_JAVA != nil],
       ["term",     ENV['TERM']],
       ["disp",     ENV['DISPLAY']],
       ["edit",     ENV['EDITOR']]]
    end

    #Get the path.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def path
      [["path"].concat(ENV['PATH'].split(File::PATH_SEPARATOR))]
    end

  end

  desc = 'Get information about the current shell environment. ' +
         'See ?env for more.'
  SHOW.add_action(EnvInfoCommand.new('env', desc))
end
