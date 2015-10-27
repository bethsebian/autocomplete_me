gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'node.rb'

class NodeTest < Minitest::Test
  def test_new_node_defines_its_own_letter_with_first_letter_from_passed_array
    word_array = ["t","e","s","t"]
    test_node = Node.new(word_array)

    assert_equal "t", test_node.own_letter
  end

  def test_it_has_default_selection_value_of_zero
    test_node = Node.new([])

    assert_equal 0, test_node.selections
    refute_equal 5, test_node.selections
  end

  def test_it_can_be_initialized_with_an_empty_array
    test_node = Node.new()

    assert test_node
  end

  def test_it_has_default_word_indicator_of_false
    test_node = Node.new(["t","e","s","t"])

    assert_equal false, test_node.word?
    refute test_node.word?
  end

  def test_it_is_initialized_with_an_empty_hash_of_alphabet_keys
    test_node = Node.new(["t","e","s","t"])
    assert_equal Hash["a","","b","","c","","d","","e","","f","","g","","h","","i","","j","","k","","l","","m","","n","","o","","p","","q","","r","","s","","t","","u","","v","","w","","x","","y","","z",""], test_node.alphabet_hash
  end
end

