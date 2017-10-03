require 'byebug'

class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end

    self
  end

  def my_select(&prc)
    result = []
    self.my_each { |num| result << num if prc.call(num) }
    result
  end

  def my_reject(&prc)
    result = []
    self.my_each { |num| result << num if !prc.call(num) }
    result
  end

  def my_any?(&prc)
    self.my_each { |num| return true if prc.call(num) }
    false
  end

  def my_all?(&prc)
    self.my_each { |num| return false if !prc.call(num) }
    true
  end

  def my_flatten
    result = []
    self.each do |num|
      # debugger
      if num.is_a?(Array)
        result.concat(num.my_flatten)
      else
        result << num
      end
    end
    result
  end

  def my_zip(*arg)
    result = Array.new(self.length) { [] }
    self.each_with_index do |e, i|
      result[i] << e
      arg.each do |el|
        if el[i].nil?
          result[i] << nil
        else
          result[i] << el[i]
        end
      end
    end
    result
  end

  def my_rotate(value = 1)
    new_value = value % self.length
    new_value.times do
      self << self.shift
    end
    self
  end

  def my_join(separator = "")
    result = ""
    self.each_with_index do |letter, i|
      result << letter
      result << separator unless i == self.length - 1
    end
    result
  end

  def my_reverse
    result = []
    self.my_each do |e|
      result.unshift(e)
    end
    result
  end
end
