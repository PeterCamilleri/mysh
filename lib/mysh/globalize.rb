# coding: utf-8

#Monkey patches for mysh global entities.
class Object

  #Make the environment variable store accessible everywhere.
  MNV = Mysh::MNV

  private

  #The mysh equivalent of the system method.
  #<br>Endemic Code Smells
  #* :reek:UtilityFunction
  def mysh(str)
    Mysh.try_execute_command(str)
  end

end
