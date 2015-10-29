gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me.rb'

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

    assert_equal ["b", "f", "h", "m", "s", "u"], trie.root.links_hash.keys.sort
    assert_equal ["k","m"], trie.root.link("u").links_hash.keys.sort
  end

  def test_it_bulk_uploads_dictionary_words
    trie = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)

    assert_equal Node, trie.root.link("a").class
    assert_equal Node, trie.root.link("z").class
    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"], trie.root.links_hash.keys.sort
  end

  def test_it_navigates_to_end_node_when_given_prefix_string
    trie = CompleteMe.new
    trie.insert("treat")
    trie.insert("trek")
    trie.insert("trump")
    trie.insert("trunk")

    assert_equal trie.root.link("t").link("r").link("e"), trie.navigate_to_node_at_end_of_prefix_chain("tre")
  end

  def test_it_collects_potential_matches_from_the_last_node_in_prefix_string
    trie = CompleteMe.new
    trie.insert("treat")
    trie.insert("trek")
    trie.insert("trump")
    trie.insert("trunk")

    assert_equal trie.root.link("t").link("r").link("e"), trie.navigate_to_node_at_end_of_prefix_chain("tre")
  end

  def test_it_suggest_words_in_response_to_given_prefix
    trie = CompleteMe.new
    trie.insert("treat")
    trie.insert("trek")
    trie.insert("trump")
    trie.insert("trunk")

    assert_equal ["treat","trek"], trie.suggest("tre")
    assert_equal ["treat", "trek", "trump", "trunk"], trie.suggest("tr")
  end

  def test_it_counts_words_in_dictionary
    trie = CompleteMe.new
    trie.insert("treat")
    trie.insert("trek")
    trie.insert("trump")
    trie.insert("trunk")

    assert_equal 4, trie.count
  end

  def test_trie_triggers_node_to_store_data_about_prompts_that_lead_to_its_selection
    trie = CompleteMe.new
    trie.insert("trek")
    trie.select("tre", "trek")

    assert_equal Hash("tre"=>1), trie.navigate_to_node_at_end_of_prefix_chain("trek").prompts_hash
  end

  def test_it_suggest_words_in_response_to_given_prefix_ordered_by_selected_occurrence
    trie = CompleteMe.new
    trie.insert("jan")
    trie.insert("jam")
    trie.insert("january")
    trie.insert("janitor")

    trie.select("ja", "january")
    trie.select("ja", "january")
    trie.select("ja", "january")
    trie.select("ja", "janitor")
    trie.select("ja", "janitor")

    assert_equal ["january","janitor","jam","jan"], trie.suggest("ja")
  end
end