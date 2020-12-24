Food = Struct.new(:ingredients, :allergens)

foods = File.read('inputs/day21').split("\n").map { |line|
  ingredients = line[/(.*) \(/, 1].split
  allergens = line[/\(contains (.*)\)/, 1].split(', ')
  Food.new(ingredients, allergens)
}

allergens_by_ingredient = {}
unknown_allergens = foods.flat_map(&:allergens).uniq

while unknown_allergens.any?
  unknown_allergens.each do |allergen|
    foods_with_allergen = foods.select { |f| f.allergens.include?(allergen) }
    common_ingredients = foods_with_allergen.map(&:ingredients).reduce(:&)
    common_ingredients -= allergens_by_ingredient.keys
    if common_ingredients.size == 1
      allergens_by_ingredient[common_ingredients.first] = allergen
      unknown_allergens.delete(allergen)
    end
  end
end

safe_ingredient_count = foods.sum { |food|
  food.ingredients.count { |i| !allergens_by_ingredient.key?(i) }
}
puts safe_ingredient_count

dangerous_ingredients = allergens_by_ingredient.sort_by(&:last).map(&:first)
puts dangerous_ingredients.join(',')
