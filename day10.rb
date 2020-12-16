joltages = [0] + File.read('inputs/day10').split.map(&:to_i).sort

diffs = joltages.map.with_index { |j, i|
  (joltages[i + 1] || joltages.last + 3) - j
}
puts diffs.count(1) * diffs.count(3)

ways = {0 => 1}
ways.default = 0
joltages.each do |j|
  ways[j + 1] += ways[j]
  ways[j + 2] += ways[j]
  ways[j + 3] += ways[j]
end

puts ways[joltages.last + 3]
