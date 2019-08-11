class Node
    # The node of the tree.
    # Each node has one character as its member.
    def initialize(value_)
        @value = value_
        @children = []
        @visited = false
    end

    def to_s
        return @value.to_s
    end

    def add_child(child_)
        @children.append(child_)
    end
end


class ArrayConstructor
    #This class has:
    #    a function which constructs a tree by words
    #    a function which dumps the tree as a LOUDS bit-string
    def initialize
        @tree = Node.new ('')  #The root node
    end

    # Add a word to the tree
    def add(word)
        build(@tree, word)
    end

    # Build a tree
    def build(node, word, depth=0)
        if(depth == len(word))
            return
        end

        node.children.each do |child|
            # if the child which its value is word[depth] exists,
            # continue building the tree from the next to the child.
            if(child.value == word[depth])
                self.build(child, word, depth+1)
                return
            end
        end

        # if the child which its value is word[depth] doesn't exist,
        # make a node and continue constructing the tree.
        child = Node.new(word[depth])
        node.add_child(child)
        build(child, word, depth+1)
        return
    end

    def show
        show_(@tree)
    end

    def show_(node, depth=0)
        puts format("%s%s", '  '*depth, node)
        node.children.each do |child|
            show_(child, depth+1)
        end
    end

    # Dump a LOUDS bit-string
    def dump
        # from collections import deque

        bit_array = [1, 0]  # [1, 0] indicates the 0th node
        labels = ['']

        #dumps by Breadth-first search
        queue = deque()
        queue.append(@tree)

        while len(queue) != 0
            node = queue.popleft()
            labels.append(node.value)

            bit_array += [1] * len(node.children) + [0]

            node.children.each do |child|
                child.visited = True
                queue.append(child)
            end
        end
        [bit_array, labels]
    end
end

        
