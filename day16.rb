at_exit do
  sections = File.read('inputs/day16').split("\n\n")
  rules = parse_rules(sections[0])
  my_ticket_nums = parse_tickets(sections[1]).first
  tickets = parse_tickets(sections[2])

  puts ticket_scanning_error_rate(tickets, rules)

  field_names = resolve_field_names(tickets, rules)
  my_ticket = field_names.zip(my_ticket_nums)
  departure_nums = my_ticket.map { |field_name, num|
    num if field_name.start_with?('departure')
  }.compact
  puts departure_nums.reduce(:*)
end

def parse_rules(s)
  s.split("\n").map { |line|
    field_name = line.split(':').first
    ranges = line.scan(/\d+-\d+/).map { |r|
      from, to = r.split('-').map(&:to_i)
      from..to
    }
    rule = ->(n) { ranges.any? { |r| r.cover?(n) } }
    [field_name, rule]
  }.to_h
end

def parse_tickets(s)
  s.split("\n").drop(1).map { |line| line.split(',').map(&:to_i) }
end

def ticket_scanning_error_rate(tickets, rules)
  invalid_nums = tickets.flat_map { |t|
    t.select { |n| !is_valid?(n, rules) }
  }
  invalid_nums.sum
end

def resolve_field_names(tickets, rules)
  valid_tickets = tickets.select { |t| t.all? { |n| is_valid?(n, rules) } }
  field_count = tickets.first.size
  possible_field_names = (0...field_count).map { |field_index|
    rules.select { |rule_name, rule|
      valid_tickets.all? { |t| rule.call(t[field_index]) }
    }.map(&:first)
  }
  field_names = Array.new(field_count)
  while field_names.any?(&:nil?)
    unique_field_index = possible_field_names.index { |names| names.size === 1 }
    name = possible_field_names[unique_field_index].first
    field_names[unique_field_index] = name
    possible_field_names.each do |names|
      names.delete(name)
    end
  end
  field_names
end

def is_valid?(number, rules)
  rules.any? { |_, rule| rule.call(number) }
end
