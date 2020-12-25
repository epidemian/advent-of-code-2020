public_keys = [6929599, 2448427]

loop_sizes = public_keys.map { |public_key|
  i = 0
  n = 1
  while n != public_key
    n *= 7
    n %= 20201227
    i += 1
  end
  i
}

private_keys = public_keys.zip(loop_sizes.reverse).map { |key, loop_size|
  n = 1
  loop_size.times do
    n *= key
    n %= 20201227
  end
  n
}

private_keys.first == private_keys.last or fail
puts private_keys.first
