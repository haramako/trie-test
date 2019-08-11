require './constructor'

# NOTE:
# It would be quite difficult to understand this code if you are not familiar
# with LOUDS.
class Trie
    attr_reader :bit_array
    attr_reader :labels

    def initialize(words)
        @bit_array, @labels = words_to_arrays(words)
    end

    def lower(words)
        words = words.map{|w| w.downcase }
        words.sort()
        return words
    end

    # Convert words to a LOUDS bit-string
    def words_to_arrays(words)
        words = lower(words)

        constructor = ArrayConstructor.new
        words.each do |word|
            constructor.add(word)
        end
        constructor.show
        bit_array, labels = constructor.dump()
        return bit_array, labels
    end

    # Returns the location of the nth target bit
    def select(n, target_bit)
        @bit_array.size.times do |i|
            if(@bit_array[i] == target_bit)
                n -= 1
            end
            if(n == 0)
                return i
            end
        end
        return nil
    end

    # Returns the number of target bits from head to the position in the bit string.
    def rank(position, target_bit)
        n = 0
        for bit in @bit_array[0,position+1]
            if(bit == target_bit)
                n += 1
            end
        end
        return n
    end

    # If the character is found among the children of current_node,
    # this method returns the node number of the child, None otherwise.
    def trace_children(current_node, character)
        index = select(current_node, 0) + 1
        # search brothers
        while(@bit_array[index] == 1)
            node = rank(index, 1)
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
        query = query.downcase

        node = 1
        query.each_char do |c|
            # puts "#{c} #{node}"
            node = trace_children(node, c)
            return nil if node.nil?  #the query is not in the tree
        end
        node
    end
end
