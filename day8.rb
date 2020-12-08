require 'ostruct'

program = File.read('day8-input').split("\n").map { |line|
  op, arg = line.split
  [op.to_sym, arg.to_i]
}

def run(program)
  acc = 0
  pc = 0
  loop_detector = []

  while pc < program.length
    op, arg = program[pc]

    break if loop_detector[pc]
    loop_detector[pc] = true

    case op
    when :acc
      acc += arg
      pc += 1
    when :jmp
      pc += arg
    when :nop
      pc += 1
    end
  end

  OpenStruct.new(halts: loop_detector[pc].nil?, acc: acc)
end

puts run(program).acc

program.each_with_index do |ins, i|
  op, arg = ins
  next if op == :acc

  new_op = op == :nop ? :jmp : :nop
  altered_program = program.dup
  altered_program[i] = [new_op, arg]

  result = run(altered_program)
  puts result.acc if result.halts
end
