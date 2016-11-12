# coding: utf-8

#Object monkey patch for the mysh lineage method.
class Object

  #Get the lineage of this object.
  def lineage
    klass = self.class
    to_s + " of " + klass.lineage
  end

end

#Class monkey patch for the mysh lineage method.
class Class

  #Get the lineage of this class.
  def lineage
    klass = superclass
    (name || to_s) + (klass ? " < " + klass.lineage : "")
  end

end

