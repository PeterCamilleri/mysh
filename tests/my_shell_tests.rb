# coding: utf-8

require_relative '../lib/mysh'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class MyShellTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  #Evaluate the string in a mysh context.
  def mysh_eval(str)
    @mysh_binding ||= binding

    @mysh_binding.eval(str)
  end

  def test_that_module_entities_exists
    assert_equal(String, Mysh::VERSION.class)

    assert_equal(Module, Mysh.class)
    assert_equal(Class,  Mysh::Action.class)
    assert_equal(Class,  Mysh::ActionPool.class)
    assert_equal(Class,  Mysh::ExecHost.class)

    assert_equal(Mysh::ActionPool, Mysh::COMMANDS.class)
    assert_equal(Mysh::ActionPool, Mysh::Action::HELP.class)
  end

  def test_for_internal_commands
    assert(Mysh::COMMANDS['exit'], "The exit command is missing.")
    assert(Mysh::COMMANDS['quit'], "The quit command is missing.")

    assert(Mysh::COMMANDS['history'], "The history command is missing.")
    assert(Mysh::COMMANDS['!'], "The ! command is missing.")

    assert(Mysh::COMMANDS['help'], "The help command is missing.")
    assert(Mysh::COMMANDS['?'], "The ? command is missing.")

    assert(Mysh::COMMANDS['cd'], "The cd command is missing.")
    assert(Mysh::COMMANDS['pwd'], "The pwd command is missing.")

    assert_raises { Mysh::COMMANDS.add_alias('blam', 'shazzam') }
  end

  def test_handlebars
    assert_equal("ABC 123 DEF",
                 eval_handlebars("ABC {{ (1..3).to_a.join }} DEF"))

    assert_equal("ABC", eval_handlebars("{{ 'ABC'  }}"))
    assert_equal("",    eval_handlebars("{{ 'ABC' #}}"))

    assert_equal("{{ 'ABC' }}", eval_handlebars("\\{\\{ 'ABC' \\}\\}"))
    assert_equal("{{A}}", eval_handlebars("{{ '{'+'{A}'+'}' }}"))
  end

  def test_command_parsing
    assert_equal([], Mysh.parse_args(""))

    assert_equal(["1", "2", "3"], Mysh.parse_args("1 2 3"))

    assert_equal(["1", "Trump", "loses", "election", "3"],
                 Mysh.parse_args("1 Trump loses election 3"))

    assert_equal(["1", "Trump loses election", "3"],
                 Mysh.parse_args('1 "Trump loses election" 3'))

  end

  def test_the_lineage_method
    assert_equal("String instance < String < Object < BasicObject",
                 "Hello".lineage)

    assert_equal("Fixnum instance < Fixnum < Integer < Numeric < Object < BasicObject",
                 (4).lineage)
  end

  def test_some_formatting
    result =
      ["1 5 9  13 17 21 25 29 33 37 41 45 49 53 57 61 65 69 73 77 81 85 89 93 97 ",
       "2 6 10 14 18 22 26 30 34 38 42 46 50 54 58 62 66 70 74 78 82 86 90 94 98 ",
       "3 7 11 15 19 23 27 31 35 39 43 47 51 55 59 63 67 71 75 79 83 87 91 95 99 ",
       "4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100"]

    assert_equal(result, (1..100).to_a.format_mysh_columns)

    result =
      ["key_largo /long_folder_name_one/long_folder_name_two/long_folder_name_three/fin",
       "          e_descriptive_name",
       "key_west  Semper ubi sub ubi. Semper ubi sub ubi. Semper ubi sub ubi. Semper",
       "          ubi sub ubi."]

    data =
      [["key_largo", "/long_folder_name_one/long_folder_name_two/long_folder_name_three/fine_descriptive_name"],
       ["key_west",  "Semper ubi sub ubi. Semper ubi sub ubi. Semper ubi sub ubi. Semper ubi sub ubi. "]
      ]

    assert_equal(result, data.mysh_bulletize)


  end

end
