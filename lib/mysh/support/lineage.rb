# coding: utf-8

#Object monkey patch for the mysh lineage command.
class Object

  def lineage
    klass = self.class
    klass.name + " instance < " + klass.lineage
  end

end

#Class monkey patch for the mysh lineage command.
class Class

  def lineage
    klass = superclass
    name + (klass ? " < " + klass.lineage : "")
  end

end

