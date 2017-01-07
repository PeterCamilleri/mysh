# coding: utf-8

#Monkey patches for mysh global entities.
class Object

  #Make the environment variable store accessible everywhere.
  MNV = Mysh::MNV

  private

  #The mysh equivalent of the system method.
  def mysh(str)
    Mysh.try_execute_command(str)
  end

end
