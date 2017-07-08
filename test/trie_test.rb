require './test/test_helper'
require './lib/trie'

class TrieTest < Minitest::Test
  attr_reader :trie

  def setup
    @trie       = Trie.new
  end

  def test_it_exists
    assert_instance_of Trie, trie
  end

  def test_root_is_node
    assert_instance_of Node, trie.root
  end

  def test_it_can_insert_word
    trie.insert("pizza")
    assert_equal 1, trie.count
  end

  def test_it_can_suggest_word
    trie.insert("pizza")
    assert_equal ["pizza"], trie.suggest("piz")
  end
end
