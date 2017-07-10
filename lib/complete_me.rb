require './lib/trie'

class CompleteMe

  attr_accessor :trie

  def initialize
    @trie = Trie.new
  end

  def insert(word)
    trie.insert(word)
  end

  def populate(dictionary)
    trie.populate(dictionary)
  end

  def suggest(string)
    trie.suggest(string)
  end

  def count
    trie.count
  end

  def select(substr, word)
    trie.select(substr, word)
  end

end