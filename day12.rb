instructions = File.read('inputs/day12').split.map { |l|
  l =~ /(\w)(\d+)/
  [$1.to_sym, $2.to_i]
}

# Remove redundant S, W and R instructions.
instructions.map! { |action, value|
  case action
  when :S then [:N, -value]
  when :W then [:E, -value]
  when :R then [:L, -value % 360]
  else [action, value]
  end
}

pos_east = 0
pos_north = 0
dir_east = 1
dir_north = 0

instructions.each do |action, value|
  case action
  when :N then pos_north += value
  when :E then pos_east += value
  when :L
    (value / 90).times do
      dir_east, dir_north = -dir_north, dir_east
    end
  when :F
    pos_east += dir_east * value
    pos_north += dir_north * value
  end
end

puts pos_east.abs + pos_north.abs

pos_east = 0
pos_north = 0
way_north = 1
way_east = 10

instructions.each do |action, value|
  case action
  when :N then way_north += value
  when :E then way_east += value
  when :L
    (value / 90).times do
      way_east, way_north = -way_north, way_east
    end
  when :F
    pos_east += way_east * value
    pos_north += way_north * value
  end
end

puts pos_east.abs + pos_north.abs
