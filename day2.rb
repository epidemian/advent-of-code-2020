lines = File.read('day2-input').split("\n")
data = lines.map { |l| l.match(/(\d+)-(\d+) (\w): (\w+)/).to_a.drop(1) }

puts data.count { |min, max, ch, pass|
  pass.count(ch).between?(min.to_i, max.to_i)
}

puts data.count { |idx1, idx2, ch, pass|
  (pass[idx1.to_i - 1] == ch) ^ (pass[idx2.to_i - 1] == ch)
}
