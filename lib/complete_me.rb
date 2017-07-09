require 'pry'
require './lib/trie'

class CompleteMe
  attr_reader :trie
              :count

  def initialize
    @trie = Trie.new
    @count = 0
  end

  def insert(word)
    trie.insert(word)
    @count += 1
  end
end