require 'pry'

class Node
  attr_accessor :selections, :word

  def initialize(array=[])
    @array = array
    @selections = 0
    @word = false
  end

  def own_letter
    @array[0]
  end

  def selections
    @selections
  end

  def word?
    @word
  end

  def alphabet_hash
    Hash["a","","b","","c","","d","","e","","f","","g","","h","","i","","j","","k","","l","","m","","n","","o","","p","","q","","r","","s","","t","","u","","v","","w","","x","","y","","z",""]
  end

end
