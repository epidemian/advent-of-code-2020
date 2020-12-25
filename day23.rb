at_exit do
  cups = '952438716'.chars.map(&:to_i)
  graph = crab_cups(cups, 100)
  n = 1
  puts 8.times.map { n = graph[n] }.join

  cups += (10..1_000_000).to_a
  graph = crab_cups(cups, 10_000_000)
  puts graph[1] * graph[graph[1]]
end

def crab_cups(cups, n_moves)
  max_cup = cups.size
  graph = []
  cups.zip(cups.rotate) do |cup, next_cup|
    graph[cup] = next_cup
  end
  curr = cups.first
  n_moves.times do |n|
    pick_1 = graph[curr]
    pick_2 = graph[pick_1]
    pick_3 = graph[pick_2]
    graph[curr] = graph[pick_3]
    dest = prev(curr, max_cup)
    dest = prev(dest, max_cup) while [pick_1, pick_2, pick_3].include?(dest)
    graph[dest], graph[pick_3] = pick_1, graph[dest]
    curr = graph[curr]
  end
  graph
end

def prev(n, max_cup)
  n == 1 ? max_cup : n - 1
end
