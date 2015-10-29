gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node.rb'

class NodeTest < Minitest::Test
  def test_new_node_with_empty_array_has_empty_links_hash
    test_node = Node.new()

    assert_equal Hash.new, test_node.my_hash
    assert test_node.my_hash.empty?
  end

  def test_new_node_with_1_letter_array_creates_key_letter_and_value_new_node
    test_node = Node.new("e")

    assert test_node.link("e").object_id
    refute test_node.link("a")
  end

  def test_new_node_with_2_letter_array_creates_1_child_with_1_child
    test_node = Node.new("fu")

    assert test_node.link("f").object_id
    assert test_node.link("f").link("u").object_id
    refute test_node.link("a")
    assert_equal nil, test_node.link("f").link("g")
   end

   def test_new_node_with_5_letter_array_creates_5_generations
    test_node = Node.new("funny")

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
    test_node = Node.new("test")

    assert_equal false, test_node.word?
    refute test_node.word?
  end

  def test_node_returns_child_for_given_key_if_one_exists
    test_node = Node.new("test")

    assert_equal test_node.link("t"), test_node.returns("t")
    assert_equal test_node.link("t").link("e"), test_node.link("t").returns("e")
  end

  def test_node_knows_to_return_child_if_child_exists
    test_node = Node.new("test")

    link_t_1 = test_node.link("t")
    test_node.advance("t")
    link_t_2 = test_node.link("t")

    assert_equal link_t_1, link_t_2
  end

  def test_node_knows_to_create_child_if_no_child_exists
    test_node = Node.new("test")

    link_t_1 = test_node.link("h") # nil
    test_node.advance("h")
    link_t_2 = test_node.link("h")

    refute link_t_1
    assert link_t_2
  end

  def test_mark_node_as_end_of_word_when_node_reps_last_letter_in_string
    test_node = Node.new("test")

    assert test_node.link("t").link("e").link("s").link("t").word?
    refute test_node.link("t").link("e").link("s").word?
    refute test_node.link("t").link("e").word?
    refute test_node.link("t").word?
    refute test_node.word?
  end

  def test_mark_node_as_end_of_word_when_node_reps_last_letter_in_string
    test_node = Node.new("meat")
    test_node.advance("me")

    assert test_node.link("m").link("e").link("a").link("t").word?
    assert test_node.link("m").link("e").word?
    refute test_node.link("m").link("e").link("a").word?
    refute test_node.link("m").word?
    refute test_node.word?
  end

  def test_it_provides_list_of_children_words
    test_node = Node.new("trek")
    test_node.advance("treat")
    test_node.advance("trump")

    assert_equal ["a","k"], test_node.link("t").link("r").link("e").my_hash.keys.sort
    assert_equal ["treat","trek"], test_node.link("t").link("r").link("e").collect("tre")
  end

  def test_node_is_initialized_with_empty_hash_of_prompts
    test_node = Node.new("trek")

    assert_equal Hash.new, test_node.link("t").link("r").link("e").link("k").hash_of_prompts
  end

  def test_node_captures_prefix_used_to_select_the_word_it_represents
    test_node = Node.new("trek")
    test_node.advance("treat")
    test_node.advance("trump")
    test_node.link("t").link("r").link("e").link("k").node_selected("tre")

    assert_equal Hash("tre"=>1), test_node.link("t").link("r").link("e").link("k").hash_of_prompts

    test_node.link("t").link("r").link("e").link("k").node_selected("tre")
    assert_equal Hash("tre"=>2), test_node.link("t").link("r").link("e").link("k").hash_of_prompts
  end
end

