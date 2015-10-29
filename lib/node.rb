require 'pry'

class Node
  attr_accessor :selections, :word, :array, :alphabet_hash, :word_list

  def initialize(word_rest="")
    if word_rest.class == Array
      @word_rest = word_rest
    elsif word_rest.class == String
      @word_rest = word_rest.chars
    end
    @selections = 0
    @word = false
    @my_hash = Hash.new
    @hash_of_prompts = Hash.new
    advance(word_rest)
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

  def create_child(input)
    if input.class == Array
      input_array = input
    elsif input.class == String
      input_array = input.chars
    end
    key = input_array[0]
    input_array.shift
    add_key_and_new_node_link_to_hash(key, value = Node.new(input_array))
  end

  def word?
    @word
  end

  def my_hash
    @my_hash
  end

  def collect(prefix,word_list=[])
    if @word == true
      word_list.push(prefix)
    end
    if my_hash.empty?
    else
      @my_hash.each do |key, value|
        value.collect(prefix+key,word_list)
      end
    end
    word_list.sort
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

  def node_selected(key)
    if @hash_of_prompts[key].nil?
      @hash_of_prompts[key] = 1
    else
      selected_times = @hash_of_prompts[key]
      @hash_of_prompts[key] += 1
    end
  end

  def hash_of_prompts
    @hash_of_prompts
  end
end