require 'pry'
require './node'

class Trie
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(word)
    current_node = @root
    word.each_char do |char|
      if current_node.in_children(char)
        current_node = current_node.children[char]
      else
        current_node.children[char] = Node.new
        current_node = current_node.children[char]
      end
    end
    current_node.end_of_word = true
  end
end