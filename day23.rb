cups = '952438716'.chars.map(&:to_i)

def circular(n)
  n.zero? ? 9 : n
end

100.times do
  picked = cups[1..3]
  cups[1..3] = []
  destination = circular(cups.first - 1)
  destination = circular(destination - 1) while picked.include?(destination)
  cups.insert(cups.index(destination) + 1, *picked)
  cups.rotate!
end

puts cups.rotate(cups.index(1)).drop(1).join
