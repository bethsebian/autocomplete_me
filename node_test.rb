gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'node.rb'

class NodeTest < Minitest::Test
  def test_new_node_defines_its_own_letter
    word_array = ["t","e","s","t"]
    test_node = Node.new(word_array)
    assert_equal "t", test_node.own_letter
  end
end