# coding: utf-8

#* mysh/internal/actions/vars.rb -- The mysh internal variables commands.
module Mysh

  #* mysh/internal/actions/show.rb -- The mysh internal show command.
  class VarsCommand < Action

    VAR_EXP = %r{(?<name>   [a-z][a-z0-9_]*){0}
                 (?<equals> =){0}
                 (?<value>  \S.*){0}
                 \$ (\g<name> \s* (\g<equals> \s* \g<value>?)?)?}x

    #Execute a command against the internal mysh varaibles.
    def call(str)
      #Parse the expression.
      match = VAR_EXP.match(str.chomp)
      name, equals, value = match[:name], match[:equals], match[:value]

      if value
        assign_value(name, value)
      elsif equals
        erase_value(name)
      elsif name
        show_value(name)
      else
        show_all_values
      end

      true
    end

    def assign_value(name, value)
      MNV[name.to_sym] = value
    end

    def erase_value(name)
      MNV[name.to_sym] = ""
    end

    def show_value(name)
      puts "#{name} = #{MNV.get_source(name.to_sym)}"
    end

    def show_all_values
      puts MNV.keys
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
