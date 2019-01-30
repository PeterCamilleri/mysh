# coding: utf-8

# Get info on the mysh environment.
module Mysh

  # Get info on the mysh environment.
  class EnvInfoCommand < Action

    # Execute the @env shell command.
    def process_command(_args)
      print WORKING
      Gem.refresh

      puts "Key mysh environment information.", "",
           info.format_output_bullets, "",
           path.format_output_bullets, ""
    end

    private

    # Get the info
    # Endemic Code Smells :reek:UtilityFunction
    def info
      [["about",     Mysh::DESCRIPTION],
       ["version",   Mysh::VERSION],
       ["installed", Gem::Specification.find_all_by_name("mysh")
                                       .map{|s| s.version.to_s}
                                       .join(", ")],
       ["latest",    insouciant {latest_version_for("mysh").to_s}],
       ["init file", $mysh_init_file.to_host_spec],
       ["user",      ENV['USER']],
       ["home",      (ENV['HOME'] || "").to_host_spec],
       ["name",      (t = MNV[:name]).empty? ? $PROGRAM_NAME.to_host_spec : t],
       ["os shell",  (ENV['SHELL'] || ENV['ComSpec'] || "").to_host_spec],
       ["host",      ENV['HOSTNAME'] || ENV['COMPUTERNAME']],
       ["os",        ENV['OS']],
       ["platform",  MiniTerm::TERM_PLATFORM],
       ["java?",     MiniTerm.java? ? true : false],
       ["PID",       $PROCESS_ID]
      ]
    end

    # Get the path.
    # Endemic Code Smells :reek:UtilityFunction
    def path
      [["path"].concat(ENV['PATH'].split(File::PATH_SEPARATOR))]
    end

  end

  desc = 'Get information about the current shell environment. ' +
         'See ?env for more.'
  SHOW.add_action(EnvInfoCommand.new('env', desc))
end
