require 'pry'

class Node
  attr_accessor :children
                :complete_word
                :end_of_word

  def initialize(word)
    @children = {}
    @complete_word = {}
    @end_of_word = false
  end
  