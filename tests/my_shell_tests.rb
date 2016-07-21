# coding: utf-8

require_relative '../lib/mysh'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class MyShellTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_module_entities_exists
    assert_equal(Module, Mysh.class)
  end

  def test_for_internal_commands
    assert(Mysh::InternalCommand.commands['exit'], "The exit command is missing.")
    assert(Mysh::InternalCommand.commands['quit'], "The quit command is missing.")
  end
end
