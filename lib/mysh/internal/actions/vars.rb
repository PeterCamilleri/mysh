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
      @name = @equals = @value = nil
      super(name, description)
    end

    #Execute a command against the internal mysh variables.
    def call(str)
      match = VAR_EXP.match(str.chomp)
      @name, @equals, @value = match[:name], match[:equals], match[:value]
      do_command
      true
    end

    #Do the actual work here.
    def do_command
      sym = @name.to_sym if @name

      if @value
        MNV[sym] = @value
      elsif @equals
        MNV[sym] = ""
      elsif @name
        puts "#{@name} = #{MNV.get_source(sym)}"
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
  desc = 'Set/query mysh variables. See ?$ for more.'
  VARS_COMMAND = VarsCommand.new('$<name>=value', desc)
  COMMANDS.add_action(VARS_COMMAND)
end
