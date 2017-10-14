require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if self[key].include?(key)
    if num_buckets == @count
      resize!
    end
    self[key] << key
    @count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return unless self[key].include?(key)
    self[key].delete(key)
    @count -= 1
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) { Array.new }
    @store.each do |arr|
      arr.each do |e|
        new_store[e % (num_buckets*2)] << e
      end
    end
    @store = new_store
  end
end
