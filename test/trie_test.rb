require 'minitest/autorun'
require 'minitest/pride'
require './lib/trie.rb'

class TrieTest < Minitest::TrieTest
  def test_insert_method
    target = Node.new