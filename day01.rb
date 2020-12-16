nums = File.read('inputs/day01').split.map(&:to_i)

a, b = nums.combination(2).find { |a, b| a + b == 2020 }
puts a * b

a, b, c = nums.combination(3).find { |a, b, c| a + b + c == 2020 }
puts a * b * c
