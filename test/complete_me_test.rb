require './test/test_helper'
require './lib/complete_me'

class TrieTest < Minitest::Test
  attr_reader :cm

  def setup
    @cm = CompleteMe.new
  end

  def test_it_exists
    assert_instance_of Trie, cm.trie
  end

  def test_root_is_node
    assert_instance_of Node, cm.trie.root
  end

  def test_it_can_insert_word
    cm.insert("pizza")
    assert_equal 1, cm.count
  end

  def test_it_can_insert_multiple_words
    cm.insert("never")
    cm.insert("gonna")
    cm.insert("give")
    cm.insert("you")
    cm.insert("up")
    assert_equal 5, cm.count
  end

  def test_it_can_populate
    dictionary = File.read("/usr/share/dict/words")
    cm.populate(dictionary)
    assert_equal 235886, cm.count
  end

  def test_it_can_suggest_word
    cm.insert("pizza")
    assert_equal ["pizza"], cm.suggest("piz")
  end

  def test_it_can_suggest_a_dictionary_word
    dictionary = File.read("/usr/share/dict/words")
    cm.populate(dictionary)
    assert_equal ["whippersnapper"], cm.suggest("whippers")
  end

  def test_select_weighs_one_word
    cm.insert("pizza")
    last_node = cm.trie.get_last_node("piz")
    assert_equal ({}), last_node.complete_word
    cm.select("piz", "pizza")
    assert_equal ({"pizza" => 1}), last_node.complete_word
  end

  def test_select_weighs_multiple_selections
    cm.insert("apple")
    cm.insert("apartment")
    cm.insert("appliance")
    last_node = cm.trie.get_last_node("ap")
    assert_equal ({}), last_node.complete_word
    cm.select("ap", "apartment")
    cm.select("ap", "apple")
    cm.select("ap", "apple")
    cm.select("ap", "appliance")
    assert_equal ({"apartment" => 1, "apple" => 2, "appliance" => 1}),
      last_node.complete_word
  end

  def test_it_can_sort_by_weight
    cm.insert("apple")
    cm.insert("apartment")
    cm.insert("appliance")
    cm.select("ap", "apartment")
    cm.select("ap", "apartment")
    cm.select("ap", "apple")
    cm.select("ap", "apple")
    cm.select("ap", "apple")
    cm.select("ap", "appliance")
    expected = ["apple", "apartment", "appliance"]
    assert_equal expected, cm.suggest("ap")
  end
end
