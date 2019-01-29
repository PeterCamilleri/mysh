# coding: utf-8

# Monkey patches for mysh global entities.
class Object

  # Make the environment variable store accessible everywhere.
  MNV = Mysh::MNV

  private

  # The mysh equivalent of the system method.
  # Endemic Code Smells  :reek:UtilityFunction
  def mysh(str)
    Mysh.try_execute_command(str)
  end

  # Unwrap one mysh layer.
  def cancel
    raise MyshExit
  end

  # Run some code with no wuccas.
  def insouciant
    yield
  rescue => err
    err.to_s
  end

  # Get the latest version for the named gem. Patched code.
  def latest_version_for(name, fetcher=nil)
    dependency = Gem::Dependency.new(name)
    fetcher  ||= Gem::SpecFetcher.new

    if specs = fetcher.spec_for_dependency(dependency)[0][-1]
      specs[0].version
    else
      "<Not found in repository>"
    end
  end

end
