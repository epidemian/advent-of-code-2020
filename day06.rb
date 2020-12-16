groups = File.read('inputs/day06').split("\n\n").map { |g| g.split.map(&:chars) }

puts groups.sum { |g| g.reduce(:|).size }
puts groups.sum { |g| g.reduce(:&).size }
