def first_anagram?(word_per, word_tar)
  per = word_per.split('').permutation.map &:join
  per.include?(word_tar)
end

# p first_anagram?('Hello', 'Hello')
# p first_anagram?('Hello', 'elloH')

def second_anagram?(word, word_tar)
  arr = word.split('')
  arr_tar = word_tar.split('')
  arr_dup = arr.dup

  arr.each do |el|
    if arr_tar.include?(el)
      arr_dup.delete(el)
      arr_tar.delete(el)
    end
  end

  arr_tar.empty? && arr_dup.empty?
end

# p second_anagram?('Hello', 'Hellb')
# p second_anagram?('Hello', 'elloH')

def third_anagram?(word, word_tar)
  word.split('').sort == word_tar.split('').sort
end

# p third_anagram?('Hello', 'Hellb')
# p third_anagram?('Hello', 'elloH')

def fourth_anagram?(word, word_tar)
  arr = word.split('')
  arr_tar = word_tar.split('')
  return false if arr.length != arr_tar.length
  count1 = Hash.new(0)
  count2 = Hash.new(0)

  (0...arr.length).each do |i|
    count1[arr[i]] += 1
    count2[arr_tar[i]] += 1
  end

  count2 == count1
end

# p fourth_anagram?('Hello', 'Hellb')
# p fourth_anagram?('Hello', 'elloH')

def fourth_anagram_one?(word, word_tar)
  arr = word.split('')
  arr_tar = word_tar.split('')
  return false if arr.length != arr_tar.length
  count = Hash.new(0)

  (0...arr.length).each do |i|
    count[arr[i]] += 1
    count[arr_tar[i]] -= 1
  end

  count.values.all? { |v| v == 0 }
end

p fourth_anagram_one?('Hello', 'Hellb')
p fourth_anagram_one?('Hello', 'elloH')
