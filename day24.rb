step_list = File.read('inputs/day24').lines.map { |l|
  l.scan(/e|se|sw|w|nw|ne/).map(&:to_sym)
}
direction_map = {
  e: [2, 0],
  se: [1, -1],
  sw: [-1, -1],
  w: [-2, 0],
  nw: [-1, 1],
  ne: [1, 1],
}
directions = direction_map.values

tiles = {}
step_list.each do |steps|
  x = y = 0
  steps.each do |step|
    dx, dy = direction_map[step]
    x += dx
    y += dy
  end
  tiles[[x, y]] ^= true
end

# true = black
puts tiles.values.count(true)

100.times do |n|
  positions = []
  tiles.each do |pos, is_black|
    next unless is_black
    positions << pos
    x, y = pos
    directions.each do |dx, dy|
      positions << [x + dx, y + dy]
    end
  end
  positions.uniq!

  new_tiles = {}
  positions.each do |pos|
    x, y = pos
    black_neighbors = directions.count { |dx, dy| tiles[[x + dx, y + dy]] }
    if tiles[pos]
      new_tiles[pos] = true if black_neighbors.between?(1, 2)
    else
      new_tiles[pos] = true if black_neighbors == 2
    end
  end

  tiles = new_tiles
end

puts tiles.values.count(true)
