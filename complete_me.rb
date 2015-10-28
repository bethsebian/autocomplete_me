require_relative 'node.rb'

class CompleteMe
  attr_accessor :root

  def insert(word)
    if root.nil?
      @root = Node.new(word.chars)
    else
      root.advance(word.chars)
    end
  end
end