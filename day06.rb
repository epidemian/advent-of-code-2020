groups = File.read('day6-input').split("\n\n").map { |g| g.split.map(&:chars) }

puts groups.sum { |g| g.reduce(:|).size }
puts groups.sum { |g| g.reduce(:&).size }
