MAP = File.read('day3-input').split
HEIGHT = MAP.length
WIDTH = MAP[0].length

def count_trees(slope_right, slope_down)
  x = y = tree_count = 0
  while y < HEIGHT
    tree_count += 1 if MAP[y][x] == '#'
    x = (x + slope_right) % WIDTH
    y += slope_down
  end
  tree_count
end

puts count_trees(3, 1)

slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]
puts slopes.map { |s| count_trees(*s) }.reduce(:*)
