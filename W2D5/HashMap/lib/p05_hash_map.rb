require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    list(key).include?(key)
  end

  def set(key, val)
    if list(key).include?(key)
      list(key).update(key, val)
    else
      resize! if @count == num_buckets
      list(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    list(key).get(key)
  end

  def delete(key)
    if include?(key)
      list(key).remove(key)
      @count -= 1
    end
  end

  def list(key)
    @store[key.hash % num_buckets]
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) { LinkedList.new }
    @store.each do |list|
      list.each do |node|
        new_store[node.key.hash % (num_buckets*2)].append(node.key, node.val)
      end
    end
    @store = new_store

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
