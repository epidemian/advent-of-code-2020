require 'set'

s = File.read('inputs/day17')

def make_grid
  Hash.new { |h, x| h[x] = Hash.new { |h, y| h[y] = {} } }
end

lines = s.split

grid = make_grid
lines.each_with_index do |line, y|
  line.chars.each_with_index do |ch, x|
    grid[x][y][0] = true if ch == '#'
  end
end

x_min, x_max = 0, lines.first.size
y_min, y_max = 0, lines.size
z_min, z_max = 0, 0

def count_active_neighbors(grid, x, y, z)
  count = 0
  (x - 1 .. x + 1).each do |ix|
    (y - 1 .. y + 1).each do |iy|
      (z - 1 .. z + 1).each do |iz|
        count += 1 if grid[ix][iy][iz] && !(ix == x && iy == y && iz == z)
      end
    end
  end
  count
end

active_count = 0
6.times do
  next_grid = make_grid
  active_count = 0
  (x_min - 1 .. x_max + 1).each do |x|
    (y_min - 1 .. y_max + 1).each do |y|
      (z_min - 1 .. z_max + 1).each do |z|
        is_active = grid[x][y][z]
        active_neighbors = count_active_neighbors(grid, x, y, z)
        if is_active
          next_active = active_neighbors.between?(2, 3)
        else
          next_active = active_neighbors == 3
        end
        if next_active
          next_grid[x][y][z] = true
          active_count += 1
          x_min, x_max = [x_min, x_max, x].minmax
          y_min, y_max = [y_min, y_max, y].minmax
          z_min, z_max = [z_min, z_max, z].minmax
        end
      end
    end
  end
  grid = next_grid
end

puts active_count

# Part 2

def make_grid_2
  Hash.new { |h, x| h[x] = Hash.new { |h, y| h[y] = Hash.new { |h, z| h[z] = {} } } }
end

lines = s.split

grid = make_grid_2
lines.each_with_index do |line, y|
  line.chars.each_with_index do |ch, x|
    grid[x][y][0][0] = true if ch == '#'
  end
end

x_min, x_max = 0, lines.first.size
y_min, y_max = 0, lines.size
z_min, z_max = 0, 0
w_min, w_max = 0, 0

def count_active_neighbors_2(grid, x, y, z, w)
  count = 0
  (x - 1 .. x + 1).each do |ix|
    (y - 1 .. y + 1).each do |iy|
      (z - 1 .. z + 1).each do |iz|
        (w - 1 .. w + 1).each do |iw|
          count += 1 if grid[ix][iy][iz][iw] && !(ix == x && iy == y && iz == z && iw == w)
        end
      end
    end
  end
  count
end

6.times do
  next_grid = make_grid_2
  active_count = 0
  (x_min - 1 .. x_max + 1).each do |x|
    (y_min - 1 .. y_max + 1).each do |y|
      (z_min - 1 .. z_max + 1).each do |z|
        (w_min - 1 .. w_max + 1).each do |w|
          is_active = grid[x][y][z][w]
          active_neighbors = count_active_neighbors_2(grid, x, y, z, w)
          if is_active
            next_active = active_neighbors.between?(2, 3)
          else
            next_active = active_neighbors == 3
          end
          if next_active
            next_grid[x][y][z][w] = true
            active_count += 1
            x_min, x_max = [x_min, x_max, x].minmax
            y_min, y_max = [y_min, y_max, y].minmax
            z_min, z_max = [z_min, z_max, z].minmax
            w_min, w_max = [w_min, w_max, w].minmax
          end
        end
      end
    end
  end
  grid = next_grid
end

puts active_count
