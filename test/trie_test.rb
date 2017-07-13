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
    trie.insert("never")
    trie.insert("gonna")
    trie.insert("give")
    trie.insert("you")
    trie.insert("up")
    assert_equal 5, trie.count
  end

  def test_it_doesnt_create_node_with_empty_insert
    trie.insert("")
    assert_equal 0, trie.count
  end

  def test_it_can_populate
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)
    assert_equal 235886, trie.count
  end

  def test_it_can_populate_different_file
    dictionary = File.read("./test/medium.txt")
    trie.populate(dictionary)
    assert_equal 1000, trie.count
  end

  def test_it_can_suggest_from_different_library
    dictionary = File.read("./test/medium.txt")
    trie.populate(dictionary)
    assert_equal ["wizardly"], trie.suggest("wiz")
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

  def test_select_weighs_one_word
    trie.insert("pizza")
    last_node = trie.get_last_node("piz")
    assert_equal ({}), last_node.complete_word
    trie.select("piz", "pizza")
    assert_equal ({"pizza" => 1}), last_node.complete_word
  end

  def test_select_weighs_multiple_selections
    trie.insert("apple")
    trie.insert("apartment")
    trie.insert("appliance")
    last_node = trie.get_last_node("ap")
    assert_equal ({}), last_node.complete_word
    trie.select("ap", "apartment")
    trie.select("ap", "apple")
    trie.select("ap", "apple")
    trie.select("ap", "appliance")
    assert_equal ({"apartment" => 1, "apple" => 2, "appliance" => 1}),
      last_node.complete_word
  end

  def test_it_can_sort_by_weight
    trie.insert("apple")
    trie.insert("apartment")
    trie.insert("appliance")
    trie.select("ap", "apartment")
    trie.select("ap", "apartment")
    trie.select("ap", "apple")
    trie.select("ap", "apple")
    trie.select("ap", "apple")
    trie.select("ap", "appliance")
    expected = ["apple", "apartment", "appliance"]
    assert_equal expected, trie.suggest("ap")
  end

  def test_it_can_count_addresses
    filename = "test/addresses.csv"
    addy=trie.addresses(filename)
    trie.populate(addy)
    assert_equal 304558, trie.count
  end

  def test_it_can_suggest_addresses
    addy = trie.addresses("./test/address_fixture.csv")
    trie.populate(addy)
    expected = ["5878 N Beeler Ct", "5881 N Beeler St", "5882 N Beeler Ct"]
    assert_equal expected, trie.suggest("58")
  end

  def test_it_can_sort_by_weight_prefix
    trie.insert("apple")
    trie.insert("apartment")
    trie.insert("appliance")
    trie.select("ap", "apartment")
    trie.select("ap", "apartment")
    trie.select("ap", "apple")
    trie.select("ap", "apple")
    trie.select("ap", "apple")
    trie.select("ap", "appliance")
    trie.select("app", "apartment")
    trie.select("app", "apartment")
    trie.select("app", "apple")
    trie.select("app", "apple")
    trie.select("app", "appliance")
    trie.select("app", "appliance")
    trie.select("app", "appliance")
    expected_1 = ["apple", "apartment", "appliance"]
    expected_2 = ["appliance", "apple", "apartment"]
    assert_equal expected_1, trie.suggest("ap")
    assert_equal expected_2, trie.suggest("app")
  end

  def test_it_can_get_last_node
    trie.insert("pizza")
    expected = trie.root.children["p"].children["i"].children["z"]
    assert_equal expected, trie.get_last_node("piz")
  end

end
