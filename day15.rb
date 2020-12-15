def nth_number(initial_nums, n)
  last_seen = []
  prev_n = nil
  (1..n).each do |turn|
    if turn <= initial_nums.size
      curr_n = initial_nums[turn - 1]
    else
      prev_turn = last_seen[prev_n]
      curr_n = prev_turn ? turn - prev_turn - 1 : 0
    end
    last_seen[prev_n] = turn - 1 if prev_n
    prev_n = curr_n
  end
  prev_n
end

initial_nums = [20,9,11,0,1,2]

puts nth_number(initial_nums, 2020)
puts nth_number(initial_nums, 30_000_000)
