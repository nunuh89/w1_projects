def two_sum?(arr, target)
  arr.each_with_index do |el1, i|
    arr.each_with_index do |el2, j|
      return true if el1 + el2 == target && i != j
    end
  end
  false
end

arr = [0, 5, 1, 7]
# p two_sum?(arr, 6) #true
# p two_sum?(arr, 10) #false

def two_sum_sort?(arr, target)
  sorted_arr = arr.sort

  sorted_arr.each_with_index do |el, i|
    index_reverse = sorted_arr.length - i -1
    return true if el + sorted_arr[index_reverse] == target
    return false if i > arr.length / 2
  end
end

# p two_sum_sort?(arr, 6) #true
# p two_sum_sort?(arr, 10) #false

def two_sum_hash?(arr, target)
  h = Hash.new
  arr.each_with_index do |e,i|
    h[e] = i
  end
  return h[target - e].empty?
end

p two_sum_hash?(arr, 6) #true
p two_sum_hash?(arr, 10) #false
