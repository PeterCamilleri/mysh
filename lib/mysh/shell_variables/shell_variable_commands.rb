# coding: utf-8

#* mysh/shell_variables/shell_variable_commands.rb -- Commands for shell vars.
module Mysh

  VAR_EXP = %r{(?<name>   [a-z][a-z0-9_]*){0}
               (?<equals> =){0}
               (?<value>  \S.*){0}
               \$ (\g<name> \s* (\g<equals> \s* \g<value>?)?)?}x

  #Process a command that manipulates the shell variables.
  #<br>Endemic Code Smells
  #* :reek:TooManyStatements
  def self.shell_variable_command(str)
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

  def self.assign_value(name, value)
    MNV[name.to_sym] = value
  end

  def self.erase_value(name)
    MNV[name.to_sym] = ""
  end

  def self.show_value(name)
    puts "#{name} = #{MNV.get_source(name.to_sym)}"
  end

  def self.show_all_values
    puts MNV.keys
            .sort
            .map {|sym| ["$" + sym.to_s, MNV.get_source(sym)]}
            .format_mysh_bullets
  end

end

