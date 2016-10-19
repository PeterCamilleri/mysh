# coding: utf-8

#* internal/actions/help/shell.rb -- Get help on the shell environment.
module Mysh

  #* internal/actions/help/shell.rb -- Get help on the shell environment.
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
      [["user",  ENV['USER']],
       ["home",  ENV['HOME']],
       ["name",  decorate($PROGRAM_NAME)],
       ["shell", ENV['SHELL']    || ENV['ComSpec']],
       ["host",  ENV['HOSTNAME'] || ENV['COMPUTERNAME']],
       ["os",    ENV['OS']],
       ["term",  ENV['TERM']],
       ["disp",  ENV['DISPLAY']],
       ["edit",  ENV['EDITOR']]]
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
