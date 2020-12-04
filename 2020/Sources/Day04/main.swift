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

var rawPassport: [String.SubSequence] = []
var passports: [[String: String]] = []
let lines = input.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
for (i, line) in lines.enumerated() {
    if !line.isEmpty {
        rawPassport.append(line)
    }

    if line.isEmpty || i == lines.count - 1 {
        let fields = rawPassport
            .joined(separator: " ")
            .split(separator: " ")
            .map { field -> (String, String) in
                let split = field.split(separator: ":")
                return (String(split[0]), String(split[1]))
            }
        let passport = Dictionary(fields, uniquingKeysWith: { (first, _) in first })
        print(passport)
        if requiredFields.allSatisfy({ passport.keys.contains($0) }) {
            passports.append(passport)
        }
        rawPassport = []
    }
}

print("Answer 1: \(passports.count)")

let validPassports = passports.reduce(0) { validCount, passport in
    guard let byr = Int(passport["byr"]!), byr >= 1920, byr <= 2002 else { return validCount }
    guard let iyr = Int(passport["iyr"]!), iyr >= 2010, iyr <= 2020 else { return validCount }
    guard let eyr = Int(passport["eyr"]!), eyr >= 2020, eyr <= 2030 else { return validCount }

    let hgt = passport["hgt"]!
    if hgt.hasSuffix("cm") {
        guard let hgtInt = Int(hgt.dropLast(2)), hgtInt >= 150, hgtInt <= 193 else { return validCount }
    } else if hgt.hasSuffix("in") {
        guard let hgtInt = Int(hgt.dropLast(2)), hgtInt >= 59, hgtInt <= 76 else { return validCount }
    } else {
        return validCount
    }

    let hcl = passport["hcl"]!
    let hclColor = hcl.dropFirst()
    guard hcl.hasPrefix("#"), hclColor.count == 6, hclColor.allSatisfy({ "0123456789abcdef".contains($0) }) else { return validCount }

    let ecl = passport["ecl"]!
    guard ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(ecl) else { return validCount }

    let pid = passport["pid"]!
    guard pid.count == 9, pid.allSatisfy({ "0123456789".contains($0) }) else { return validCount }

    return validCount + 1
}

print("Answer 2: \(validPassports)")
