class Node
  attr_accessor :children,
                :end_of_word,
                :completed_word

  def initialize
    @children = {}
    @completed_word = {}
    @end_of_word = false
  end

end
