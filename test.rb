require 'pp'
require './trie'

words = ['an', 'i', 'of', 'one', 'our', 'out']
test_set = {
    'out' => 11,   #'t' in 'out' is at 11th node in the tree
    'our' => 10,   #'r' in 'our' is at 10th node in the tree
    'of' => 6,
    'i' => 3,
    'an' => 5,
    'one' => 9,
    'ant' => nil,  #'ant' is not in the tree
}

trie = Trie::Trie.new(words)

pp trie.bit_array.bit_array
pp trie.labels

test_set.each do |query, answer|
  result = trie.search(query)
  puts "query: %-8s  result: %4s answer: %4s" % [query, result, answer]
end

trie.scan
