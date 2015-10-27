require 'pry'

class Node
  attr_accessor :selections, :word, :array, :alphabet_hash

  def initialize(array=[])
    @array = array
    @selections = 0
    @word = false
    @my_hash = Hash.new
    create_child(array)
  end

  def selections
    @selections
  end

  def create_child(input_array)
    if input_array.empty?
    else
      key = input_array[0]
      input_array.shift
      add_key_and_value_to_hash(key, value = Node.new(input_array))
    end
  end

  def word?
    @word
  end

  def my_hash
    @my_hash
  end

  def add_key_and_value_to_hash(key,value)
    @my_hash[key] = value
  end

  def link(key)
    @my_hash[key]
  end

  def returns(key)
    @my_hash[key] ? @my_hash[key] : "bam"
  end

  def advance(input)
    input_array = [input]
    if @my_hash[input_array[0]]
      @my_hash[input_array[0]]
    else
      key = input_array[0]
      input_array.shift
      add_key_and_value_to_hash(key, value = Node.new(input_array))
    end
  end

end