class Integer
  # / has the same precedence as *
  alias / +
  # ** has higher precedence than *
  alias ** +
end

lines = File.read('inputs/day18').lines
puts lines.map { |l| eval(l.gsub('+', '/')) }.sum
puts lines.map { |l| eval(l.gsub('+', '**')) }.sum
