at_exit do
  n_cycles = 6
  str = File.read('inputs/day17')
  grid_3d = Grid.parse(str, 3)
  grid_4d = Grid.parse(str, 4)

  puts grid_3d.simulate_cycles(n_cycles).active_count
  puts grid_4d.simulate_cycles(n_cycles).active_count
end

class Grid
  def self.parse(str, n_dim)
    grid = new(n_dim)
    zeroes = [0] * (n_dim - 2)
    str.split.each_with_index do |line, y|
      line.chars.each_with_index do |ch, x|
        grid.active!(x, y, *zeroes) if ch == '#'
      end
    end
    grid
  end

  def self.new(n_dim)
    if n_dim == 0
      Grid0.new
    else
      super
    end
  end

  def initialize(n_dim)
    @n_dim = n_dim
    @subgrids = {}
  end

  def simulate_cycles(n_cycles)
    if n_cycles.zero?
      self
    else
      next_grid.simulate_cycles(n_cycles - 1)
    end
  end

  def active?(n, *rest)
    @subgrids[n] && @subgrids[n].active?(*rest)
  end

  def active!(n, *rest)
    (@subgrids[n] ||= Grid.new(@n_dim - 1)).active!(*rest)
  end

  def next_grid
    next_grid = Grid.new(@n_dim)
    each_possible_next_cube do |coords|
      active_neighbors = count_active_neighbors(*coords)
      if active?(*coords)
        # Note: active_neighbors includes cube at these coordinates.
        next_active = (active_neighbors - 1).between?(2, 3)
      else
        next_active = active_neighbors == 3
      end
      if next_active
        next_grid.active!(*coords)
      end
    end
    next_grid
  end

  def each_possible_next_cube
    @subgrids.each do |n, subgrid|
      subgrid.each_possible_next_cube do |coords|
        yield [n - 1, *coords]
        yield [n, *coords]
        yield [n + 1, *coords]
      end
    end
  end

  def count_active_neighbors(n, *rest)
    @subgrids[n - 1]&.count_active_neighbors(*rest).to_i +
    @subgrids[n]&.count_active_neighbors(*rest).to_i +
    @subgrids[n + 1]&.count_active_neighbors(*rest).to_i
  end

  def active_count
    @subgrids.each_value.sum(&:active_count)
  end
end

class Grid0
  def active!
  end

  def each_possible_next_cube
    yield
  end

  def count_active_neighbors
    1
  end

  def active?
    true
  end

  def active_count
    1
  end
end
