require 'minitest/autorun'
require 'minitest/pride'
require './lib/node.rb'

class NodeTest < Minitest::Test
  def test_node_class_works
    target = Node.new
    assert target
  end





end