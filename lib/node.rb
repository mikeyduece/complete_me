class Node
  attr_accessor :children,
                :end_of_word,
                :complete_word

  def initialize
    @children = {}
    @complete_word = {}
    @end_of_word = false
  end

end
