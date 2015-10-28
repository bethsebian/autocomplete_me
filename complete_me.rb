require_relative 'node.rb'

class CompleteMe
  attr_accessor :root, :counter

  def insert(word)
    if root.nil?
      @root = Node.new(word.chars)
    else
      root.advance(word.chars)
    end
  end

  def populate(location)
    location_array = location.downcase.split("\n")
    location_array.each do |word|
      insert(word)
    end
  end

  def navigate_to_end_of_prefix_node(prefix) # tre
    prefix_unchanged = prefix # tre
    prefix = prefix.chars # ["t","r","e"]
    current = root # root
    prefix.each do |char|
      current = current.link(char)
    end
    current
  end

  def suggest(prefix)
    navigate_to_end_of_prefix_node(prefix).collect(prefix)
  end
end