def windowed_max_range(arr, w)
  current_max_range = nil
  arr.each_with_index do |e, i|
    if i + w - 1 < arr.length
      window = arr[i...i+w]
      p window
      w_max = window.max
      w_min = window.min
      range = w_max - w_min
      if current_max_range.nil?
        current_max_range = range
      else
        current_max_range = range if range > current_max_range
      end
    end
  end
  current_max_range
end


# p windowed_max_range([1, 0, 2, 5, 4, 8], 2)# == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3)# == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4)# == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5)# == 6 # 3, 2, 5, 4, 8

class MyStack
  attr_reader :stack
  def initialize
    @stack = []
  end

  def push(el)
    @stack << el
  end

  def pop
    @stack.pop
  end

  def peek
    @stack.last
  end

  def empty?
    @stack.empty?
  end
end

class MinMaxStack
  attr_reader :node
  def initialize
    @node = nil
  end

  def push(el)
    new_node = Node.new
    new_node.value = el
    if @node.nil?
      new_node.max = el
      new_node.min = el
      @node = new_node
    else
      old_max = @node.max
      old_min = @node.min
      new_node.max = (old_max > el) ? old_max : el
      new_node.min = (old_min < el) ? old_min : el
      new_node.prev = @node
      @node = new_node
    end
  end

  def pop
    val = @node.value
    @node = @node.prev
    val
  end

  def peek
    @node.value
  end

  def max
    @node.max unless @node.nil?
    nil
  end

  def min
    @node.min unless @node.nil?
    nil
  end

  def empty?
    @node.nil?
  end
end

class Node
  attr_accessor :value, :max, :min, :prev
  def initialize
    @value = nil
    @max = nil
    @min = nil
    @prev = nil
  end
end

# b = MinMaxStack.new
#
# b.push(1)
# b.push(4)
# b.push(2)
# b.push(3)
# p b
#
# b.pop
# p b


class StackQueue
  def initialize
    @in_stack = MyStack.new
    @out_stack = MyStack.new
  end

  def enqueue(el)
    @in_stack.push(el)
  end

  def dequeue
    if @out_stack.empty?
      until @in_stack.empty?
        @out_stack.push(@in_stack.pop)
      end
    end
    @out_stack.pop
  end

  def peek
    if @out_stack.empty?
      until @in_stack.empty?
        @out_stack.push(@in_stack.pop)
      end
    end
    @out_stack.peek
  end

  def size
    @out_stack.count + @in_stack.count
  end

  def empty?
    size == 0
  end

end

class MinMaxStackQueue
  def initialize
    @in_stack = MinMaxStack.new
    @out_stack = MinMaxStack.new
  end

  def enqueue(el)
    @in_stack.push(el)
  end

  def dequeue
    if @out_stack.empty?
      until @in_stack.empty?
        @out_stack.push(@in_stack.pop)
      end
    end
    @out_stack.pop
  end

  def peek
    if @out_stack.empty?
      until @in_stack.empty?
        @out_stack.push(@in_stack.pop)
      end
    end
    @out_stack.peek
  end

  def min
    if @out_stack.empty?
      until @in_stack.empty?
        @out_stack.push(@in_stack.pop)
      end
    end
    @out_stack.min
  end

  def max
    if @out_stack.empty?
      until @in_stack.empty?
        @out_stack.push(@in_stack.pop)
      end
    end
    @out_stack.max
  end

  def size
    @out_stack.count + @in_stack.count
  end

  def empty?
    size == 0
  end

end


class MyQueue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue << el
  end

  def dequeue
    @queue.shift
  end

  def peek
    @queue.first
  end

  def size
    @quene.length
  end

  def empty?
    @queue.empty?
  end
end

# a = MyQueue.new
# b = StackQueue.new
#
# a.enqueue(1)
# a.enqueue(2)
# a.enqueue(3)
# peek_val = a.peek
# p peek_val
#
# b.enqueue(1)
# b.enqueue(2)
# b.enqueue(3)
# peek_val = b.peek
# p peek_val

# b = MinMaxStackQueue.new
#
# b.enqueue(1)
# b.enqueue(4)
# b.enqueue(2)
# b.enqueue(3)
# b.enqueue(7)
# b.enqueue(0)
# b.enqueue(11)
# b.dequeue
# b.dequeue
# p b
# puts b.max
# puts b.min
