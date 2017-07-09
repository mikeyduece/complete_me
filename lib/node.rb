require 'pry'

class Node
  attr_accessor :children
                :complete_word
                :end_of_word

  def initialize
    @children = {}
    @complete_word = {}
    @end_of_word = false
  end

  def in_children?(char)
    @chldren.key?(char)
  end
end