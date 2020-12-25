require 'ostruct'

RULES = File.read('inputs/day07').lines.map { |r|
  color, rest = r.split(' bags contain ')
  contents = rest.split(', ').grep(/(\d+) (\w+ \w+) bag/) {
    OpenStruct.new(count: $1.to_i, color: $2)
  }
  [color, contents]
}.to_h

def bags_containing(bag_color)
  colors = []
  RULES.each do |rule_color, contents|
    if contents.any? { |c| c.color === bag_color }
      colors.push(rule_color)
      colors.concat(bags_containing(rule_color))
    end
  end
  colors.uniq
end

def bag_count_within(bag_color)
  contents = RULES.fetch(bag_color)
  contents.sum { |c| c.count + c.count * bag_count_within(c.color) }
end

puts bags_containing('shiny gold').size
puts bag_count_within('shiny gold')
