module Trie
    class BitVector
        attr_reader :bit_array
        
        def initialize(bit_array_)
            @bit_array = bit_array_
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
            @bit_array[0,position+1].each do |bit|
                n += 1 if bit == target_bit
            end
            return n
        end

        def [](n)
            @bit_array[n]
        end
    end
end
