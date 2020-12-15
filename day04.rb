passports = File.read('day4-input')
  .split("\n\n")
  .map { |p| p.split.map{ |f| f.split(':') }.to_h }

ok_passports = passports.select { |p| (p.keys - ['cid']).size == 7 }

puts ok_passports.size

valid_passports = ok_passports.select { |p|
  [
    p['byr'].to_i.between?(1920, 2002),
    p['iyr'].to_i.between?(2010, 2020),
    p['eyr'].to_i.between?(2020, 2030),
    p['hgt'] =~ /^(\d+)(cm|in)$/ &&
      ($2 == 'cm' ? $1.to_i.between?(150, 193) : $1.to_i.between?(59, 76)),
    p['hcl'].match?(/^#[0-9a-f]{6}$/),
    %w[amb blu brn gry grn hzl oth].include?(p['ecl']),
    p['pid'].match?(/^\d{9}$/)
  ].all?
}

puts valid_passports.size
