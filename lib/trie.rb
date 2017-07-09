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
      if current_node.children.has_key?(letter)
        current_node = current_node.children[letter]
      else
        current_node.children[letter] = Node.new
        current_node = current_node.children[letter]
      end
    end
    current_node.end_of_word = true
    @count += 1
  end

  def populate(dictionary)
    dictionary.split.each do |word|
      insert(word)
    end
  end

  def suggest(string)
    sug_array = []
    get_last_node(string)
    get_all_words(get_last_node(string), string, sug_array)
    sug_array
  end

  def get_all_words(current_node=current_node, string, sug_array)
    sug_array << string if current_node.end_of_word
    if !current_node.children.empty?
      current_node.children.keys.each do |letter|
        node_string = string + letter
        get_all_words(current_node.children[letter],node_string,sug_array)
      end
    end
  end

  def get_last_node(string)
    current_node = @root
    string.each_char do |letter|
      if current_node.children.has_key?(letter)
        current_node = current_node.children[letter]
      end
    end
    current_node
  end

  def select(substr, word)
    last_node = get_last_node(substr)
    if last_node.children.has_key?(word)
      last_node.complete_word[word] += 1
    else
      last_node.complete_word[word] = 1
    end
  end


end
