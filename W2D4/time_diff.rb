

def my_min(list)
  list.each do |e|
    return e if list.all? {|l| l >= e}
  end
  return nil
end

def my_min_once(list)
  smallest = list.first
  list.each do |e|
    smallest = e if e < smallest
  end
  smallest
end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min(list)
# p my_min_once(list)


def largest_contiguous_subsum(list)
  all_subs = []
  (0...list.length).each do |i|
    (i...list.length).each do |j|
      all_subs << list[i..j]
    end
  end

  max = list.first
  all_subs.each do |sub_arr|
    sum = sub_arr.inject(:+)
    max = sum if sum > max
  end
  max
end

def largest_contiguous_subsum_linear(list)
  max_ending_here = list.first
  max_so_far = list.first

  (1...list.length).each do |i|
    max_ending_here = [max_ending_here + list[i], list[i]].max
    max_so_far = [max_ending_here, max_so_far].max
  end
  max_so_far
end

list = [2, 3, -6, 7, -6, 7]
# p largest_contiguous_subsum(list)
p largest_contiguous_subsum_linear(list)
