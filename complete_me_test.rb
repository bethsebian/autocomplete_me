gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'complete_me.rb'

class CompleteMeTest < Minitest::Test

  def test_it_creates_root_when_first_word_inserted
    trie = CompleteMe.new
    trie.insert("")

    assert_equal Node, trie.root.class
  end

  def test_it_adds_word_to_new_trie
    trie = CompleteMe.new
    trie.insert("sit")

    assert trie.root.link("s").link("i").link("t")
  end

  def test_it_knows_when_a_node_refers_to_a_word
    trie = CompleteMe.new
    trie.insert("sit")

    assert trie.root.link("s").link("i").link("t").word?
    refute trie.root.link("s").link("i").word?
  end

  def test_it_can_add_a_word_along_an_existing_route
    trie = CompleteMe.new
    trie.insert("sofa")
    trie.insert("so")

    assert trie.root.link("s").link("o").link("f").link("a").word?
    assert trie.root.link("s").link("o").word?
    refute trie.root.link("s").word?
    refute trie.root.link("s").link("o").link("f").word?
  end

  def test_it_can_add_a_word_along_an_existing_route_and_create_nodes_when_route_ends
    trie = CompleteMe.new
    trie.insert("so")
    trie.insert("sofa")

    assert trie.root.link("s").link("o").link("f").link("a").word?
    assert trie.root.link("s").link("o").word?
    refute trie.root.link("s").word?
    refute trie.root.link("s").link("o").link("f").word?
  end

  def test_it_can_incorporate_many_words
    trie = CompleteMe.new
    trie.insert("so")
    trie.insert("sofa")
    trie.insert("banana")
    trie.insert("mask")
    trie.insert("hollar")
    trie.insert("supplies")
    trie.insert("fauna")
    trie.insert("umbrella")
    trie.insert("foxy")
    trie.insert("ukelele")

    assert_equal ["b", "f", "h", "m", "s", "u"], trie.root.my_hash.keys.sort
    assert_equal ["k","m"], trie.root.link("u").my_hash.keys.sort
  end
end

