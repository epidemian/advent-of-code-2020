N = 25
nums = File.read('day9-input').split.map(&:to_i)

invalid_num = nums.drop(N).find.with_index { |num, i|
  nums[i...i + N].combination(2).none? { |a, b| a + b == num }
}
puts invalid_num

# So inefficient, but gets the job done...
from, to = (0...nums.size).to_a.combination(2).find { |i, j|
  i < j && nums[i..j].reduce(:+) == invalid_num
}
range = nums[from..to]
puts range.min + range.max
