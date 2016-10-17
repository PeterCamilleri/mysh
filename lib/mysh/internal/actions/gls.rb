# coding: utf-8

#* internal/actions/gls.rb -- The mysh gem ls command.
module Mysh

  #* internal/actions/gls.rb -- The mysh gem ls command.
  class GlsCommand < Action

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
                  .select {|spec| !(spec.name.partition(@mask)[1]).empty?}
                  .sort   {|first, second| first.name <=> second.name}
    end

    #The brief gem list report.
    def short_report
      puts @specs.map {|spec| spec.name}.format_mysh_columns.join("\n"), ""
    end

    #The long-winded gem list report.
    def long_report
      report = @specs.inject([]) do |buffer, spec|
        buffer.concat(info(spec))
      end

      puts report.mysh_bulletize.join("\n")
    end

    #Get detailed information on a gem specification.
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

  desc = 'Display the loaded ruby gems. See ? gls for more.'
  COMMANDS.add_action(GlsCommand.new('gls <-l> <mask>', desc))
end
