gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'node.rb'

class NodeTest < Minitest::Test
  def test_new_node_with_empty_array_has_empty_hash
    word_array = []
    test_node = Node.new(word_array)

    assert_equal [{}], [test_node.my_hash]
    assert test_node.my_hash.empty?
  end

  def test_new_node_with_1_letter_array_creates_key_letter_and_value_new_node
    word_array = ["e"]
    test_node = Node.new(word_array)

    assert test_node.link("e").object_id
    refute test_node.link("a")
  end

  def test_new_node_with_2_letter_array_creates_1_child_with_1_child
    word_array = ["f","u"]
    test_node = Node.new(word_array)

    assert test_node.link("f").object_id
    assert test_node.link("f").link("u").object_id
    refute test_node.link("a")
    assert_equal nil, test_node.link("f").link("g")
   end

   def test_new_node_with_5_letter_array_creates_5_generations
    word_array = ["f","u","n","n","y"]
    test_node = Node.new(word_array)

    assert test_node.link("f").link("u").link("n").link("n").link("y")
    assert_equal Node, test_node.link("f").class
    assert_equal Node, test_node.link("f").link("u").class
    assert_equal Node, test_node.link("f").link("u").link("n").class
    assert_equal Node, test_node.link("f").link("u").link("n").link("n").class
    assert_equal Node, test_node.link("f").link("u").link("n").link("n").link("y").class
    refute test_node.link("f").link("u").link("n").link("n").link("c")
    refute test_node.link("f").link("g")
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
end

