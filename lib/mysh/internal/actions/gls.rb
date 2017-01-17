# coding: utf-8

#* mysh/internal/actions/gls.rb -- The mysh gls (gem ls) command.
module Mysh

  #* mysh/internal/actions/gls.rb -- The mysh gls (gem ls) command.
  class GlsCommand < Action

    #Set up this command.
    def initialize(*args)
      super
      @report = @mask = @specs = nil
    end

    #Execute the gls command.
    def call(args)
      process_args(args)
      gather_gems
      send(@report)
    end

    private

    #Process the gls command's arguments.
    def process_args (args)
      @report, @mask = :short_report, /./

      args.each do |arg|
        if arg == '-l'
          @report = :long_report
        else
          @mask = arg
        end
      end

    end

    #Determine which of the loaded gem specs are of interest.
    def gather_gems
      @specs = Gem.loaded_specs
                  .values
                  .select {|spec| spec.name[@mask]}
                  .sort   {|first, second| first.name <=> second.name}
    end

    #The brief gem list report.
    def short_report
      puts @specs.map {|spec| spec.name}.format_mysh_columns, ""
    end

    #The long-winded gem list report.
    def long_report
      report = @specs.inject([]) do |buffer, spec|
        buffer.concat(info(spec))
      end

      puts report.format_mysh_bullets
    end

    #Get detailed information on a gem specification.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def info(spec)
      [["name",        spec.name],
       ["version",     spec.version],
       ["date",        spec.date],
       ["summary",     spec.summary],
       ["description", spec.description],
       ["executables", spec.executables],
       ["authors",     spec.authors],
       ["email",       spec.email],
       ["homepage",    spec.homepage],
       ["", ""]]
    end

  end

  desc = 'Display the loaded ruby gems. See ?gls for more.'
  COMMANDS.add_action(GlsCommand.new('gls <-l> <mask>', desc))
end
