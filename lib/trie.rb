require './lib/node'

class Trie
  attr_reader :root, :count

  def initialize
    @root = Node.new
    @count = 0
  end

  def insert(word)
    current_node = @root
    word.each_char do |letter|
      if current_node.has_kids?(letter)
        current_node = current_node.children[letter]
      else
        current_node.children[letter] = Node.new
      end
    end
    current_node.end_of_word = true
    @count += 1
  end

end
