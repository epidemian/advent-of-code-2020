at_exit do
  char_to_sym = {'.' => :floor, 'L' => :empty, '#' => :occupied}
  grid = File.read('day11-input').split.map { |l| l.chars.map(&char_to_sym) }

  stable_grid_1 = simulate_till_stable(grid,
    count_occupied: method(:adjacents_occupied),
    leave_threshold: 4
  )
  puts total_occupied(stable_grid_1)

  stable_grid_2 = simulate_till_stable(grid,
    count_occupied: method(:visible_occupied),
    leave_threshold: 5
  )
  puts total_occupied(stable_grid_2)
end

def simulate_till_stable(grid, **update_args)
  while (next_grid = update_grid(grid, **update_args)) != grid
    grid = next_grid
  end
  grid
end

def update_grid(grid, count_occupied:, leave_threshold:)
  grid.map.with_index { |line, y|
    line.map.with_index { |seat, x|
      close_occupied = count_occupied.call(grid, x, y)
      if seat == :empty && close_occupied.zero?
        :occupied
      elsif seat == :occupied && close_occupied >= leave_threshold
        :empty
      else
        seat
      end
    }
  }
end

def total_occupied(grid)
  grid.sum { |line| line.count(:occupied) }
end

DIRECTIONS = [
  [-1, -1], [-1, 0], [-1, 1],
  [0, -1],           [0, 1],
  [1, -1],  [1, 0],  [1, 1],
]

def adjacents_occupied(grid, x, y)
  DIRECTIONS.count { |dx, dy| at(grid, x + dx, y + dy) == :occupied }
end

def visible_occupied(grid, x, y)
  DIRECTIONS.count { |dx, dy| visible_from(grid, x, y, dx, dy) == :occupied }
end

def visible_from(grid, x, y, dx, dy)
  loop do
    x += dx
    y += dy
    seat = at(grid, x, y)
    return seat if seat != :floor
  end
end

def at(grid, x, y)
  grid[y][x] if y.between?(0, grid.size - 1) && x.between?(0, grid[0].size - 1)
end

