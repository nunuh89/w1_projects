class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_node = first
    found = false
    until found || current_node == @tail
      found = (key == current_node.key)
      return current_node.val if found
      current_node = current_node.next
    end
    nil
  end

  def get_node(key)
    current_node = first
    found = false
    until found || current_node == @tail
      found = (key == current_node.key)
      return current_node if found
      current_node = current_node.next
    end
    nil
  end

  def include?(key)
    current_node = first
    until current_node == @tail
      found = (key == current_node.key)
      return true if found
      current_node = current_node.next
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = @tail.prev
    @tail.prev.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    current_node = first
    found = false
    until found || current_node == @tail
      found = (key == current_node.key)
      current_node.val = val if found
      current_node = current_node.next
    end
  end

  def remove(key)
    current_node = first
    until current_node == @tail
      found = (key == current_node.key)
      if found
        current_node.prev.next = current_node.next
        current_node.next.prev = current_node.prev
        break
      end
      current_node = current_node.next
    end
    nil
  end

  def each(&prc)
    current_node = first
    until current_node == @tail
      prc.call(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
