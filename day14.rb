lines = File.read('inputs/day14').split("\n")

mem = {}
zeros_mask = 0
ones_mask = 0

lines.each do |line|
  case line
  when /mask = ([01X]+)/
    mask = $1.chars
    zeros_mask = mask.map { |c| c == '0' ? 0 : 1 }.join.to_i(2)
    ones_mask = mask.map { |c| c == '1' ? 1 : 0 }.join.to_i(2)
  when /mem\[(\d+)\] = (\d+)/
    addr = $1.to_i
    value = $2.to_i & zeros_mask | ones_mask
    mem[addr] = value
  end
end

p mem.values.sum

# V2

def set_floating(mem, addr, value, floating_bits)
  if floating_bits.empty?
    mem[addr] = value
  else
    bit_n, *rest_floating_bits = floating_bits
    flipped_addr = addr ^ 1 << bit_n
    set_floating(mem, addr, value, rest_floating_bits)
    set_floating(mem, flipped_addr, value, rest_floating_bits)
  end
end

mem = {}
ones_mask = 0
floating_bits = []

lines.each do |line|
  case line
  when /mask = ([01X]+)/
    mask = $1.chars
    ones_mask = mask.map { |c| c == '1' ? 1 : 0 }.join.to_i(2)
    floating_bits = mask.reverse.map.with_index { |c, i| i if c == 'X' }.compact
  when /mem\[(\d+)\] = (\d+)/
    addr = $1.to_i | ones_mask
    value = $2.to_i
    set_floating(mem, addr, value, floating_bits)
  end
end

p mem.values.sum
