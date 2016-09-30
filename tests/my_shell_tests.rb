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
    assert_equal(Class,  Mysh::InternalCommand.class)
    assert_equal(Class,  Mysh::ExecHost.class)
  end

  def test_for_internal_commands
    assert(Mysh::InternalCommand::COMMANDS['exit'], "The exit command is missing.")
    assert(Mysh::InternalCommand::COMMANDS['quit'], "The quit command is missing.")

    assert(Mysh::InternalCommand::COMMANDS['history'], "The history command is missing.")
    assert(Mysh::InternalCommand::COMMANDS['!'], "The ! command is missing.")

    assert(Mysh::InternalCommand::COMMANDS['help'], "The help command is missing.")
    assert(Mysh::InternalCommand::COMMANDS['?'], "The ? command is missing.")

    assert(Mysh::InternalCommand::COMMANDS['cd'], "The cd command is missing.")
    assert(Mysh::InternalCommand::COMMANDS['pwd'], "The pwd command is missing.")

    assert_raises { Mysh::InternalCommand::COMMANDS.add_alias('blam', 'shazzam') }
  end

  def test_handlebars
    cmd = Mysh::InternalCommand::COMMANDS['help']

    assert_equal("ABC 123 DEF",
                 cmd.expand_handlebars("ABC {{ (1..3).to_a.join }} DEF"))

  end

end
