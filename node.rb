require 'pry'

class Node
  attr_accessor :selections, :word, :array, :alphabet_hash

  def initialize(array=[])
    @array = array
    @selections = 0
    @word = false
    @my_hash = Hash.new
    advance(array)
  end

  def selections
    @selections
  end

  def advance(input)
    if input.class == Array
      input_array = input
    elsif input.class == String
      input_array = input.chars
    end
    if input_array.empty?
      @word = true
    elsif @my_hash[input_array[0]]
      existing_link = @my_hash[input_array[0]]
      input_array.shift
        if input_array.empty?
          existing_link.advance([])
        else existing_link.advance(input_array)
        end
      else create_child(input_array)
    end
  end

  def word?
    @word
  end

  def my_hash
    @my_hash
  end

  def create_child(input_array)
    key = input_array[0]
    input_array.shift
    add_key_and_new_node_link_to_hash(key, value = Node.new(input_array))
  end

  def add_key_and_new_node_link_to_hash(key,value)
    @my_hash[key] = value
  end

  def link(key)
    @my_hash[key]
  end

  def returns(key)
    @my_hash[key] ? @my_hash[key] : "bam"
  end
end