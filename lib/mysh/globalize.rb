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

  # Execute a block with page paused output.
  def more
    saved = $stdout

    if MNV[:page_pause].extract_mysh_types
      $stdout = OutputPager.new if (outer = $stdout.equal?($mysh_out))
    end

    yield
  rescue MyshStopOutput
    raise unless outer
    return
  ensure
    $stdout = saved
  end

end
