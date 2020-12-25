at_exit do
  tiles = File.read('inputs/day20').split("\n\n").map { |str|
    num = str[/Tile (\d+)/, 1].to_i
    data = str.lines.drop(1).map(&:strip)
    Tile.new(num, data)
  }

  tiles_by_edge = Hash.new([])
  tiles.each do |t|
    t.edges.each do |edge|
      tiles_by_edge[edge] |= [t]
      tiles_by_edge[edge.reverse] |= [t]
    end
  end

  # Insight: all tile edges are "unique", so there are only four tiles with two
  # of their edges not shared by any other tile: the 4 corners.
  corner_tiles = tiles.select { |t|
    t.edges.count { |e| tiles_by_edge[e].size == 1 } == 2
  }
  corner_tiles.size == 4 or fail
  puts corner_tiles.map(&:number).reduce(:*)

  top_left_tile = corner_tiles.first
  tiles_per_side = Math.sqrt(tiles.size).round

  # Furthermore, tile edges are unique, so we can build the arranged image
  # starting from the top-left, looking for the tiles that share the right or
  # bottom edges, and orienting them into the right position.
  arranged_tiles = [[
    top_left_tile.each_orientation.find { |t|
      tiles_by_edge[t.top].size == 1 && tiles_by_edge[t.left].size == 1
    }
  ]]
  (1...tiles_per_side).each do |row|
    tile_above = arranged_tiles[row - 1][0]
    tile = tiles_by_edge[tile_above.bottom].find { |t| t != tile_above }
    arranged_tiles[row] = [
      tile.each_orientation.find { |t| t.top == tile_above.bottom }
    ]
  end
  (0...tiles_per_side).each do |row|
    line = arranged_tiles[row]
    (1...tiles_per_side).each do |col|
      left_tile = line[col - 1]
      tile = tiles_by_edge[left_tile.right].find { |t| t != left_tile }
      line << tile.each_orientation.find { |t| t.left == left_tile.right }
    end
  end

  arranged_image_data = arranged_tiles.flat_map { |tiles_line|
    tiles_line.map(&:data_without_edges).transpose.map(&:join)
  }

  arranged_image = Tile.new(nil, arranged_image_data)
  arranged_image.each_orientation do |image|
    monster_count = 0
    (0...image.size).each do |x|
      (0...image.size).each do |y|
        has_sea_monster = SEA_MONSTER_POSITIONS.all? { |mx, my|
          image[x + mx, y + my] == '#'
        }
        if has_sea_monster
          SEA_MONSTER_POSITIONS.each do |mx, my|
            image[x + mx, y + my] = '0'
          end
          monster_count += 1
        end
      end
    end
    if monster_count > 0
      puts image.count('#')
    end
  end
end

SEA_MONSTER = [
  '                  # ',
  '#    ##    ##    ###',
  ' #  #  #  #  #  #   '
]

SEA_MONSTER_POSITIONS = []
SEA_MONSTER.each_with_index do |line, y|
  (0...line.size).each do |x|
    SEA_MONSTER_POSITIONS << [x, y] if line[x] == '#'
  end
end

class Tile
  attr_reader :number, :data

  def initialize(number, data)
    @number = number
    @data = data
  end

  def edges
    [top, bottom, left, right]
  end

  def top; data.first end
  def bottom; data.last end
  def left; data.map { |l| l[0] }.join end
  def right; data.map { |l| l[-1] }.join end

  def each_orientation(&block)
    return to_enum :each_orientation unless block
    each_rotation(&block)
    flip.each_rotation(&block)
  end

  def each_rotation
    yield aux = self
    yield aux = aux.rotate_left
    yield aux = aux.rotate_left
    yield aux = aux.rotate_left
  end

  def rotate_left
    rotated_data = data.dup.map(&:dup)
    (0...size).each do |x|
      (0...size).each do |y|
        rotated_data[size - x - 1][y] = data[y][x]
      end
    end
    Tile.new(number, rotated_data)
  end

  def flip
    Tile.new(number, data.map(&:reverse))
  end

  def data_without_edges
    data[1..-2].map { |l| l[1..-2] }
  end

  def size
    data.size
  end

  def count(char)
    data.sum { |l| l.count(char) }
  end

  def == other
    number == other.number
  end

  def [](x, y)
    data[y]&.[](x)
  end

  def []=(x, y, value)
    data[y][x] = value
  end

  private

  attr_reader :data
end

