require './constructor'
require './bit_vector'

module Trie

    # NOTE:
    # It would be quite difficult to understand this code if you are not familiar
    # with LOUDS.
    class Trie
        attr_reader :bit_array
        attr_reader :labels

        def initialize(words)
            bits, @labels, _ = words_to_arrays(words)
            @bit_array = BitVector.new(bits)
        end

        # Convert words to a LOUDS bit-string
        def words_to_arrays(words)
            constructor = ArrayConstructor.new
            words.sort.each do |word|
                constructor.add(word)
            end
            constructor.show
            constructor.dump
        end

        # If the character is found among the children of current_node,
        # this method returns the node number of the child, None otherwise.
        def trace_children(current_node, character)
            index = @bit_array.select(current_node, 0) + 1
            # search brothers
            while(@bit_array[index] == 1)
                node = @bit_array.rank(index, 1)
                # puts "scan #{character} #{index} #{node}"
                if(@labels[node] == character)
                    return node
                end
                index += 1
            end
            nil
        end

        # Returns the leaf node number if the query exists in the tree
        # None otherwise
        def search(query)
            node = 1
            query.each_char do |c|
                # puts "#{c} #{node}"
                node = trace_children(node, c)
                return nil if node.nil?  #the query is not in the tree
            end
            node
        end

        def scan
            scan_(1, [])
        end

        def scan_(parent, stack)
            index = @bit_array.select(parent, 0) + 1
            # search brothers
            while @bit_array[index] == 1
                node = @bit_array.rank(index, 1)

                stack.push @labels[node]
                puts "scan #{stack.join}"
                scan_(node, stack)
                stack.pop

                index += 1
            end
        end
    end
end
