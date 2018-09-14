# coding: utf-8

#* mysh/internal/actions/vars.rb -- The mysh internal variables commands.
module Mysh

  #* mysh/internal/actions/vars.rb -- The mysh internal variable commands.
  class VarsCommand < Action

    #The mysh variable parsing regex.
    VAR_EXP = %r{(?<name>   [a-z][a-z0-9_]*){0}
                 (?<equals> =){0}
                 (?<value>  \S.*){0}
                 \$ (\g<name> \s* (\g<equals> \s* \g<value>?)?)?}x

    #Setup an internal action.
    def initialize(name, description)
      @var_name = @equals = @value = nil
      super(name, description)
    end

    #Execute a command against the internal mysh variables.
    def process_command(input)
      match = VAR_EXP.match(input.raw_body)

      if match
        @var_name, @equals, @value = match[:name], match[:equals], match[:value]
      else
        @var_name, @equals, @value = nil
      end

      do_command
      :internal
    end

    #Do the actual work here.
    def do_command
      sym = @var_name.to_sym if @var_name

      if @value
        MNV[sym] = @value
      elsif @equals
        MNV[sym] = ""
      elsif @var_name
        puts "$#{@var_name} = #{MNV.get_source(sym)}"
      else
        show_all_values
      end
    end

    #Display all variables neatly.
    def show_all_values
      puts (MNV.keys - ['$'.to_sym])
             .sort
             .map {|sym| ["$" + sym.to_s, MNV.get_source(sym)]}
             .format_mysh_bullets
    end

  end

  #The show command action object.
  desc = 'Set/query mysh variables. See ?set for more.'
  COMMANDS.add_action(VarsCommand.new('set <$name>=value', desc))
end
