require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.each_with_index.inject(0) do |acc, (el, i)|
      (el.hash + i.hash) ^ acc
    end
  end
end

class String
  ALPHA = ("a".."z").to_a
  def hash
    ans = self.chars.map { |el| ALPHA.index(el) }
    ans.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.keys.each.inject(0) do |acc, key|
      (key.hash + self[key].hash) ^ acc
    end

    
  end
end
