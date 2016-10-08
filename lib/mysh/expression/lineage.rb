# coding: utf-8

#Object monkey patch for the mysh lineage method.
class Object

  #Get the lineage of this object.
  def lineage
    klass = self.class
    klass.name + " instance < " + klass.lineage
  end

end

#Class monkey patch for the mysh lineage method.
class Class

  #Get the lineage of this class.
  def lineage
    klass = superclass
    name + (klass ? " < " + klass.lineage : "")
  end

end

