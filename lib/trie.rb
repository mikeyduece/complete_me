require 'pry'
require './node'

class Trie
  attr_reader :root

  def initialize
    @root = Node.new
  end