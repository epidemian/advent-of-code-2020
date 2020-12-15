line_1, line_2 = File.read('day13-input').split
start_time = line_1.to_i
bus_ids = line_2.split(',').map{ |c, i| c.to_i if c != 'x' }

first_bus = bus_ids.compact.min_by { |id| (id - start_time) % id }
first_arrival = (first_bus - start_time) % first_bus
puts first_bus * first_arrival

t = 0
m = 1
bus_ids.each_with_index do |bus_id, i|
  next unless bus_id
  t += m while (bus_id - t) % bus_id != i % bus_id
  m *= bus_id
end
puts t
