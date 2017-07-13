require './lib/node'
require 'csv'

class Trie
  attr_reader :root, :count

  def initialize
    @root = Node.new
    @count = 0
  end

  def addresses(filename)
    addresses = ""
    CSV.foreach filename,  headers: true, header_converters: :symbol do |row|
      addresses << row[:full_address] + ","
    end
    addresses
  end

  def insert(word)
    current_node = @root
    return if word == ""
    traverse(word, current_node)
  end

  def traverse(word, current_node)
    word.each_char do |letter|
      if current_node.children[letter]
        current_node = current_node.children[letter]
      else
        current_node.children[letter] = Node.new
        current_node = current_node.children[letter]
      end
    end
    @count += 1 if !current_node.end_of_word
    current_node.end_of_word = true
  end

  def populate(dictionary)
    if dictionary.include?(",")
      dictionary.split(",").each {|word| insert(word)}
    else
      dictionary.split.each {|word| insert(word)}
    end
  end

  def suggest(string)
    sug_array = []
    get_all_words(get_last_node(string), string, sug_array)
    weighted_suggestions(sug_array,string)
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
      if current_node.children[letter]
        current_node = current_node.children[letter]
      end
    end
    current_node
  end

  def select(substr, word)
    last_node = get_last_node(substr)
    if last_node.complete_word[word]
      last_node.complete_word[word] += 1
    else
      last_node.complete_word[word] = 1
    end
  end

  def select_sort(last_node)
    last_node.complete_word.keys.sort_by do |k|
      last_node.complete_word[k]
    end.reverse
  end

  def weighted_suggestions(sug_array, string)
    last = get_last_node(string)
    suggested = select_sort(last)
    suggested.map {|word| sug_array.delete(word)}
    suggested + sug_array
  end

end
