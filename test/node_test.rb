require './test/test_helper'
require './lib/node'

class NodeTest < Minitest::Test

  def test_it_exists
    node = Node.new
    assert_instance_of Node, node
  end

  def test_it_has_no_kids_by_default
    node = Node.new
    assert node.children.empty?
  end

  def test_end_of_word_is_false_at_start
    node = Node.new
    refute node.end_of_word
  end
end
