require 'minitest/autorun'
require 'minitest/pride'
require './test/test_helper'
require './lib/trie'

class TrieTest < Minitest::Test
  attr_reader :trie

  def setup
    @trie = Trie.new
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

  def test_it_can_insert_multiple_words
    trie.insert("pizza")
    trie.insert("apple")
    trie.insert("bicycle")
    assert_equal 3, trie.count
  end

  def test_it_can_populate
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)
    assert_equal 235886, trie.count
  end

  def test_it_can_suggest_word
    trie.insert("pizza")
    assert_equal ["pizza"], trie.suggest("piz")
  end

  def test_it_can_suggest_a_dictionary_word
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)
    assert_equal ["whippersnapper"], trie.suggest("whippers")
  end
end
