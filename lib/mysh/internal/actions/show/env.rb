# coding: utf-8

#* mysh/internal/actions/show/env.rb -- Get help on the mysh environment.
module Mysh

  #* mysh/internal/actions/show/env.rb -- Get help on the mysh environment.
  class EnvInfoCommand < Action

    #Execute the ? shell command.
    def process_command(_args)
      puts "Key mysh environment information.", ""
      puts info.format_mysh_bullets, "",
           path.format_mysh_bullets, ""
    end

    private

    #Get the info
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def info
      [["version",   Mysh::VERSION],
       ["init file", $mysh_init_file.decorate],
       ["user",      ENV['USER']],
       ["home",      (ENV['HOME'] || "").decorate],
       ["name",      $PROGRAM_NAME.decorate],
       ["os shell",  (ENV['SHELL'] || ENV['ComSpec'] || "").decorate],
       ["host",      ENV['HOSTNAME'] || ENV['COMPUTERNAME']],
       ["os",        ENV['OS']],
       ["platform",  MiniReadline::TERM_PLATFORM],
       ["java?",     MiniReadline::TERM_JAVA ? true : false],
       ["term",      ENV['TERM']],
       ["disp",      ENV['DISPLAY']],
       ["edit",      ENV['EDITOR']],
       ["PID",       $PROCESS_ID]
      ]
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
