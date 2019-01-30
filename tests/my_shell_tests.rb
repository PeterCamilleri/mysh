# coding: utf-8

require_relative '../lib/mysh'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class MyShellTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_it_has_a_version_number
    refute_nil(::Mysh::VERSION)
    assert(::Mysh::VERSION.frozen?)
    assert(::Mysh::VERSION.is_a?(String))
    assert(/\A\d+\.\d+\.\d+/ =~ ::Mysh::VERSION)
  end

  def test_that_it_has_a_description
    refute_nil(::Mysh::DESCRIPTION)
    assert(::Mysh::DESCRIPTION.frozen?)
    assert(::Mysh::DESCRIPTION.is_a?(String))
  end

  def test_that_module_entities_exists
    assert_equal(String, Mysh::VERSION.class)

    assert_equal(Module, Mysh.class)
    assert_equal(Class,  Mysh::Action.class)
    assert_equal(Class,  Mysh::ActionPool.class)
    assert_equal(Module, Mysh::MNV.class)
    assert_equal(Class,  Mysh::Keeper.class)
    assert_equal(Class,  Mysh::InputWrapper.class)

    assert_equal(Mysh::ActionPool, Mysh::COMMANDS.class)
    assert_equal(Mysh::ActionPool, Mysh::HELP.class)
  end

  def test_for_internal_commands
    assert(Mysh::COMMANDS['exit'], "The exit command is missing.")
    assert(Mysh::COMMANDS['cancel'], "The cancel command is missing.")

    assert(Mysh::COMMANDS['history'],  "The history command is missing.")
    assert(Mysh::COMMANDS['!<arg>'], "The ! command is missing.")

    assert(Mysh::COMMANDS['help'], "The help command is missing.")
    assert(Mysh::COMMANDS['?<topic>'], "The ? command is missing.")

    assert(Mysh::COMMANDS['cd'], "The cd command is missing.")
    assert(Mysh::COMMANDS['pwd'], "The pwd command is missing.")

    assert_raises { Mysh::COMMANDS.add_alias('blam', 'shazzam') }
  end

  def test_handlebars
    assert_equal("ABC 123 DEF",
                 "ABC {{ (1..3).to_a.join }} DEF".preprocess)

    assert_equal("ABC", "{{ 'ABC'  }}".preprocess)
    assert_equal("",    "{{ 'ABC' #}}".preprocess)

    assert_equal("{{ 'ABC' }}", "\\{\\{ 'ABC' \\}\\}".preprocess)
    assert_equal("{{A}}", "{{ '{'+'{A}'+'}' }}".preprocess)
  end

  def test_command_parsing
    assert_equal([], Mysh.parse_args(""))

    assert_equal(["1", "2", "3"], Mysh.parse_args("1 2 3"))

    assert_equal(["1", "Trump", "impeached", "3"],
                 Mysh.parse_args("1 Trump impeached 3"))

    assert_equal(["1", "Trump impeached", "3"],
                 Mysh.parse_args('1 "Trump impeached" 3'))
  end

  def test_the_lineage_method
    assert_equal("Hello of String < Object < BasicObject",
                 "Hello".lineage)

    assert_equal("4 of Fixnum < Integer < Numeric < Object < BasicObject",
                 (4).lineage)
  end

  def test_mysh_variables
    assert_equal("", MNV[:test])
    assert_equal("", MNV.get_source(:test))
    refute(MNV.key?(:test), "MNV[:test] should not exist.")

    MNV[:test] = "test 1 2 3"
    assert_equal("test 1 2 3", MNV[:test])
    assert_equal("test 1 2 3", MNV.get_source(:test))
    assert(MNV.key?(:test), "MNV[:test] should exist.")

    MNV[:test] = ""
    assert_equal("", MNV[:test])
    assert_equal("", MNV.get_source(:test))
    refute(MNV.key?(:test), "MNV[:test] should not exist.")

    Mysh.try_execute_command("set $test = new value")
    assert_equal("new value", MNV[:test])
    assert_equal("new value", MNV.get_source(:test))
    assert(MNV.key?(:test), "MNV[:test] should exist.")

    Mysh.try_execute_command("set $test =")
    assert_equal("", MNV[:test])
    assert_equal("", MNV.get_source(:test))
    refute(MNV.key?(:test), "MNV[:test] should not exist.")

    Mysh.try_execute_command("set $test = true")
    assert(MNV[:test])
    assert_equal("true", MNV.get_source(:test))
    assert(MNV.key?(:test), "MNV[:test] should exist.")

    Mysh.try_execute_command("set $test = off")
    assert_equal(false, MNV[:test].extract_boolean)
    assert_equal("off", MNV[:test])
    assert(MNV.key?(:test), "MNV[:test] should exist.")

    Mysh.try_execute_command("set $a = foo")
    Mysh.try_execute_command("set $b = bar")
    Mysh.try_execute_command("set $test = $a$b")
    assert_equal("foobar", MNV[:test])
    assert_equal("$a$b", MNV.get_source(:test))

    Mysh.try_execute_command("set $test = $$foo")
    assert_equal("$foo", MNV[:test])
    assert_equal("$$foo", MNV.get_source(:test))

    Mysh.try_execute_command("set $bad = $bad")
    assert_raises { MNV[:bad] }

    MNV[:test] = "{{(1..9).to_a.join}}"
    assert_equal("123456789", MNV[:test])
    assert_equal("{{(1..9).to_a.join}}", MNV.get_source(:test))

    Mysh.try_execute_command("set $test = $whats_all_this")
    assert_equal("$whats_all_this", MNV[:test])
    assert_equal("$whats_all_this", MNV.get_source(:test))

    Mysh.try_execute_command("set $bad = {{ MNV[:bad] }}")
    assert_raises { MNV[:bad] }
    assert_raises { MNV[:bad] } #Yes test this twice!
    assert_raises { Mysh.try_execute_command("=$bad") }
    assert_raises { Mysh.try_execute_command("=$bad") } #And this too!

    Mysh.try_execute_command("set $bad = OK")
    assert_equal("OK", MNV[:bad])
    assert_equal("OK", MNV[:bad]) #And this too!
  end

  def test_executing_some_strings
    Mysh.process_string("set $c=43\nset $d=99")
    assert_equal("43", MNV[:c])
    assert_equal("99", MNV[:d])
  end

  def test_the_input_wrapper
    wrapper = Mysh::InputWrapper.new '@last 45 "is finished" {{ 2+2 }} ever'

    assert_equal('@last 45 "is finished" {{ 2+2 }} ever', wrapper.raw)
    assert_equal('@last 45 "is finished" 4 ever', wrapper.cooked)

    assert_equal('@last', wrapper.raw_command)
    assert_equal('45 "is finished" {{ 2+2 }} ever', wrapper.raw_body)

    assert_equal('@', wrapper.quick_command)
    assert_equal('last 45 "is finished" {{ 2+2 }} ever', wrapper.quick_body)

    assert_equal(["@last", "45", "is finished", "4", "ever"], wrapper.parsed)
    assert_equal(["45", "is finished", "4", "ever"], wrapper.args)

    assert_equal(wrapper, wrapper.quick)

    assert_equal('@', wrapper.raw_command)
    assert_equal('last 45 "is finished" {{ 2+2 }} ever', wrapper.raw_body)
    assert_equal(["@", "last", "45", "is finished", "4", "ever"], wrapper.parsed)
    assert_equal(["last", "45", "is finished", "4", "ever"], wrapper.args)

    Mysh.process_string("set $unjust = him")
    wrapper = Mysh::InputWrapper.new "Lock $unjust up!"

    assert_equal("Lock $unjust up!", wrapper.raw)
    assert_equal("Lock him up!", wrapper.cooked)
    assert_equal("Lock", wrapper.raw_command)
    assert_equal("$unjust up!", wrapper.raw_body)
    assert_equal("him up!", wrapper.cooked_body)

    wrapper = Mysh::InputWrapper.new "Test"
    assert_equal("Test", wrapper.raw)
    assert_equal("Test", wrapper.cooked)
    assert_equal("Test", wrapper.raw_command)
    assert_equal("", wrapper.raw_body)
    assert_equal("", wrapper.cooked_body)
  end

  def test_to_std_spec
    assert_equal("test\\foo\\bar.rb".to_std_spec, "test/foo/bar.rb")
  end

  def test_recursion_detection
    MNV[:rec_test_one] = "one"
    assert_equal("one one", "$rec_test_one $rec_test_one".preprocess)

    MNV[:rec_test_too] = "$rec_test_too".preprocess
    assert_raises { "$rec_test_too".preprocess }

    MNV[:rec_test_two] = "$rec_test_one $rec_test_one"
    assert_equal("one one", "$rec_test_two".preprocess)
  end

end
