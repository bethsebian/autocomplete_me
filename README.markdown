# Autocomplete Dictionary, "CompleteMe"
## The Problem

Everyone in today's smartphone-saturated world has had their share of interactions with textual "autocomplete." But how would you actually __make__ an autocomplete system?

In this project, __CompleteMe__, we will create a simple textual autocomplete system

## The Solution
![logo](./images/shoes.png)

A common way to solve this problem is using a data structure called a __Trie__. A Trie is somewhat similar to binary trees, but whereas each node in a binary tree points to up to 2 subtrees, nodes within our retrieval tries will point to `N` subtrees, where `N` is the size of the alphabet we want to complete within.

Thus for a simple latin-alphabet text trie, each node will potentially have 26 children, one for each character that could potentially follow the text entered thus far.

### Required Features

To complete the project, you will need to build an autocomplete
system which provides the following features:

1. Insert a single word to the autocomplete dictionary
2. Count the number of words in the dictionary
3. Populate a newline-separated list of words into the dictionary
4. Suggest completions for a substring
5. Mark a selection for a substring
6. Weight subsequent suggestions based on previous selections

### Running Locally
1. Clone the repo `$ git clone git@github.com:bethsebian/trie_hard.git autocomplete_me`
2. Navigate to autocomplete_me directory `$ cd autocomplete_me`.
3. Fire up a pry session `$ pry` from the autocomplete_me directory
4. Require the complete_me.rb file `$ require "./lib/complete_me.rb"`
5. Set a variable pointing to a new instance of the CompleteMe class `$ completion = CompleteMe.new`
6. Add words to your dictionary:
  * Add words word-by-word to the trie with `$ completion.insert("pizza")` OR
  * Add the entire Mac dictionary with `$ dictionary = File.read("/usr/share/dict/words")` and then `$ completion.populate(dictionary)`.
  * Confirm words have been added with `$ completion.count`
7. Retrieve autocomplete suggestions with the `suggest` method: `$ completion.suggest("piz")` will return `["pizza", "pizzeria", "pizzicato"]`

### Highlights
* My first complex logic application, completed my third week of Turing/programming (!).
* Usage Frequency Weighting
  * The application is able to weigh suggestions based on whether they've been selected by users in the past.
  * User can `select` a suggestion with the command `completion.select("piz", "pizzeria")`.
  * The next time `suggest` is called, the suggestions will be reordered to illustrate the weighting of "pizzeria" ahead of "pizza".

### Areas for Improvement
* The [node.rb](https://github.com/bethsebian/trie_hard/blob/master/lib/node.rb) file could be refactored and cleaned up a big, maybe extracting some methods to a third class.
* I created an user interface using shoes that needs some work still.
  To run Shoes:
    * Download Shoes for Ruby from http://shoesrb.com/.
    * Follow instructions above for "Interacting with the Trie" and populate the trie with the Mac dictionary.
    * Run Shoes.
    * Click on "Run an App" in Shoes.
    * Navigate to the shoes.rb file in this repo.
  * I'd like a cleaner way of presenting results from the user's search.
  * The dropdown boxes that show results need to be removed between each search.
