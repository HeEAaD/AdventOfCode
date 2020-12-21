import Foundation

let lines = input.split(whereSeparator: \.isNewline)

let foods: [(Set<String>, Set<String>)] = lines.map { line in
    let ingredients = line
        .split(separator: "(")[0]
        .split(separator: " ")
        .map({ String($0) })

    let allergens = line
        .split(separator: "(")[1]
        .dropLast()
        .dropFirst(9)
        .components(separatedBy: ", ")
        .map({ String($0) })

    return (Set(ingredients), Set(allergens))
}

let allAllergens = Set(foods.flatMap(\.1))

var allergenToIngredients: [String: Set<String>] = [:]
for allergen in allAllergens {
    var possibleIngredients: Set<String> = []
    for (ingredients, allergens) in foods where allergens.contains(allergen) {
        if possibleIngredients.isEmpty {
            possibleIngredients = ingredients
        } else {
            possibleIngredients = possibleIngredients.intersection(ingredients)
            if possibleIngredients.count == 1 {
                break
            }
        }
    }
    allergenToIngredients[allergen] = possibleIngredients
}

var changed = true
while changed {
    changed = false
    for (allergen, possibleIngredients) in allergenToIngredients where possibleIngredients.count == 1 {
        let ingredient = possibleIngredients.first!
        for (allergen2, var possibleIngredient2) in allergenToIngredients where allergen != allergen2 && possibleIngredient2.contains(ingredient) {
            possibleIngredient2.remove(ingredient)
            allergenToIngredients[allergen2] = possibleIngredient2
            changed = true
        }
    }
}

var ingredientToAllergen: [String: String] = [:]
for (allergen, ingredients) in allergenToIngredients {
    ingredientToAllergen[ingredients.first!] = allergen
}

var count = foods
    .map(\.0)
    .joined()
    .filter { ingredientToAllergen[$0] == nil }
    .count

print("Answer 1: \(count)")

let dangerousIngredientList = ingredientToAllergen
    .sorted { $0.value < $1.value }
    .map { $0.key }
    .joined(separator: ",")

print("Answer 2: \(dangerousIngredientList)")
