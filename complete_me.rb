require_relative 'node.rb'

class CompleteMe
  attr_accessor :root, :counter

  def counter
    @counter
  end

  def insert(word)
    @counter = 0
    if root.nil?
      @root = Node.new(word.chars)
      @counter += 2
    else
      root.advance(word.chars)
      @counter += 4
    end
  end

  def populate(location)
    location_array = location.downcase.split("\n")
    location_array.each do |word|
      insert(word)
    end
  end
end