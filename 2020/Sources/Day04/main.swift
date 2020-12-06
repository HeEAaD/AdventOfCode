let requiredFields = [
    "byr", // (Birth Year)
    "iyr", // (Issue Year)
    "eyr", // (Expiration Year)
    "hgt", // (Height)
    "hcl", // (Hair Color)
    "ecl", // (Eye Color)
    "pid", // (Passport ID)
    //"cid", //  Country ID)
]

let groups = input
    .split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
    .split(separator: "")

let passports: [[String: String]] = groups
    .map { group in
        let fields = group
            .joined(separator: " ")
            .split(separator: " ")
            .map { field -> (String, String) in
                let split = field.split(separator: ":")
                return (String(split[0]), String(split[1]))
            }
        return Dictionary(fields, uniquingKeysWith: { (first, _) in first })
    }
    .filter { passport in
        requiredFields.allSatisfy({ passport.keys.contains($0) })
    }

print("Answer 1: \(passports.count)")

let validSum = passports.reduce(into: 0) { validSum, passport in
    guard let byr = Int(passport["byr"]!), byr >= 1920, byr <= 2002 else { return }
    guard let iyr = Int(passport["iyr"]!), iyr >= 2010, iyr <= 2020 else { return }
    guard let eyr = Int(passport["eyr"]!), eyr >= 2020, eyr <= 2030 else { return }

    let hgt = passport["hgt"]!
    if hgt.hasSuffix("cm") {
        guard let hgtInt = Int(hgt.dropLast(2)), hgtInt >= 150, hgtInt <= 193 else { return }
    } else if hgt.hasSuffix("in") {
        guard let hgtInt = Int(hgt.dropLast(2)), hgtInt >= 59, hgtInt <= 76 else { return }
    } else {
        return
    }

    let hcl = passport["hcl"]!
    let hclColor = hcl.dropFirst()
    guard hcl.hasPrefix("#"), hclColor.count == 6, hclColor.allSatisfy({ "0123456789abcdef".contains($0) }) else { return }

    let ecl = passport["ecl"]!
    guard ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(ecl) else { return }

    let pid = passport["pid"]!
    guard pid.count == 9, pid.allSatisfy({ "0123456789".contains($0) }) else { return }

    validSum += 1
}

print("Answer 2: \(validSum)")
