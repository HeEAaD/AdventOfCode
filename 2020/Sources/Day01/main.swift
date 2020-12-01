let set = Set(input)

var product: Int?
for n0 in set {
    let n1 = 2020 - n0
    if n1 != n0 && set.contains(n1) {
        product = n0 * n1
        break
    }
}
print("Answer 1: \(product!)")

product = nil
for n0 in set {
    guard product == nil else { break }
    for n1 in set where n0 != n1 {
        let n2 = 2020 - n0 - n1
        if set.contains(n2) {
            product = n0 * n1 * n2
            break
        }
    }
}
print("Answer 2: \(product!)")
