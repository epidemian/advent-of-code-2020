rules_str, messages_str = File.read('inputs/day19').split("\n\n")

rules = rules_str.split("\n").map { |l| l.split(':') }.to_h
messages = messages_str.split

def create_rule_0_regex(rules)
  regex_generator = Hash.new do |h, k|
    tokens = rules[k].split
    re = tokens.map { |t|
      case t
      when /"(\w)"/ then $1
      when '|' then t
      when k then "\\g<rule#{k}>"
      else h[t]
      end
    }.join
    if tokens.include?(k)
      "(?<rule#{k}>#{re})"
    elsif tokens.include?('|')
      "(#{re})"
    else
      re
    end
  end
  Regexp.new("^#{regex_generator['0']}$")
end

puts messages.grep(create_rule_0_regex(rules)).size

rules['8'] = '42 | 42 8'
rules['11'] = '42 31 | 42 11 31'
puts messages.grep(create_rule_0_regex(rules)).size
