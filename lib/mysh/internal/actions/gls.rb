# coding: utf-8

#* internal/actions/gls.rb -- The mysh gem ls command.
module Mysh

  #* internal/actions/gls.rb -- The mysh gem ls command.
  class Action

    desc = 'Display the loaded ruby gems. See help gls for more.'

    #The Gem LS command.
    gls = COMMANDS.add('gls <-l> <mask>', desc) do |args|
      process_args(args)
      gather_gems
      send(@report)
    end

    #Process the gls command's arguments.
    gls.define_singleton_method(:process_args) do |args|
      @report, @mask = :short_report, /./

      args.each do |arg|
        if arg == '-l'
          @report = :long_report
        else
          @mask = arg
        end
      end

    end

    #Determine which of the loaded gems are of interest.
    gls.define_singleton_method(:gather_gems) do
      @specs = Gem.loaded_specs
                  .values
                  .select {|spec| !(spec.name.partition(@mask)[1]).empty?}
                  .sort   {|first, second| first.name <=> second.name}
    end

    #The brief gem list report.
    gls.define_singleton_method(:short_report) do
      puts @specs.map {|spec| spec.name}.format_mysh_columns.join("\n")
      puts
    end

    #The long-winded gem list report.
    gls.define_singleton_method(:long_report) do
      report = @specs.inject([]) do |buffer, spec|
        buffer.concat(info(spec))
      end

      #puts report
      puts report.mysh_bulletize.join("\n")
    end

    #Get detailed information on a gem specification.
    gls.define_singleton_method(:info) do |spec|
      [["name",        spec.name],
       ["version",     spec.version],
       ["date",        spec.date],
       ["summary",     spec.summary],
       ["description", spec.description],
       ["executables", spec.executables],
       ["authors",     spec.authors],
       ["email",       spec.email],
       ["homepage",    spec.homepage],
       ["", ""]
      ]

    end



  end

end

