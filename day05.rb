passes = File.read('inputs/day05').split
ids = passes.map { |s| s.tr('FBLR', '0101').to_i(2) }
puts ids.max

my_id = (ids.min..ids.max).find { |n| !ids.include?(n) }
puts my_id
