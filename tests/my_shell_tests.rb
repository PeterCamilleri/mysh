# coding: utf-8

require_relative '../lib/mysh'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class MySellTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_module_entities_exists
    assert_equal(Class, Mysh.class)
  end

end
