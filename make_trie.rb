require 'pp'
require './trie'

words = ARGF.read_lines

trie = Trie::Trie.new(words)

pp trie.bit_array.bit_array
pp trie.labels

test_set.each do |query, answer|
  result = trie.search(query)
  puts "query: %-8s  result: %4s answer: %4s" % [query, result, answer]
end
