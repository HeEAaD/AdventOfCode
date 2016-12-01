import Foundation

let replacements = ["Al => ThF","Al => ThRnFAr","B => BCa","B => TiB","B => TiRnFAr","Ca => CaCa","Ca => PB","Ca => PRnFAr","Ca => SiRnFYFAr","Ca => SiRnMgAr","Ca => SiTh","F => CaF","F => PMg","F => SiAl","H => CRnAlAr","H => CRnFYFYFAr","H => CRnFYMgAr","H => CRnMgYFAr","H => HCa","H => NRnFYFAr","H => NRnMgAr","H => NTh","H => OB","H => ORnFAr","Mg => BF","Mg => TiMg","N => CRnFAr","N => HSi","O => CRnFYFAr","O => CRnMgAr","O => HP","O => NRnFAr","O => OTi","P => CaP","P => PTi","P => SiRnFAr","Si => CaSi","Th => ThCa","Ti => BP","Ti => TiTi"].map { $0.componentsSeparatedByString(" => ") }
let generatorMolecules = ["HF","NAl","OMg"]//  ["e => HF","e => NAl","e => OMg"]
let molecule = "ORnPBPMgArCaCaCaSiThCaCaSiThCaCaPBSiRnFArRnFArCaCaSiThCaCaSiThCaCaCaCaCaCaSiRnFYFArSiRnMgArCaSiRnPTiTiBFYPBFArSiRnCaSiRnTiRnFArSiAlArPTiBPTiRnCaSiAlArCaPTiTiBPMgYFArPTiRnFArSiRnCaCaFArRnCaFArCaSiRnSiRnMgArFYCaSiRnMgArCaCaSiThPRnFArPBCaSiRnMgArCaCaSiThCaSiRnTiMgArFArSiThSiThCaCaSiRnMgArCaCaSiRnFArTiBPTiRnCaSiAlArCaPTiRnFArPBPBCaCaSiThCaPBSiThPRnFArSiThCaSiThCaSiThCaPTiBSiRnFYFArCaCaPRnFArPBCaCaPBSiRnTiRnFArCaPRnFArSiRnCaCaCaSiThCaRnCaFArYCaSiRnFArBCaCaCaSiThFArPBFArCaSiRnFArRnCaCaCaFArSiRnFArTiRnPMgArF"


//let molecule = "HOHOHO"
//let replacements = ["H => HO","H => OH","O => HH"].map { $0.componentsSeparatedByString(" => ") }
//let generatorMolecules = ["H","O"]

func replace(molecule:String) -> [String] {
    var generatedMolecules = Set<String>()
    for r in replacements {
        let reqex = try! NSRegularExpression(pattern: r[0], options: [])
        let matches = reqex.matchesInString(molecule, options: [], range: NSMakeRange(0, molecule.characters.count))
        for m in matches {
            let rangeStart = molecule.startIndex.advancedBy(m.range.location)
            let range = rangeStart..<rangeStart.advancedBy(m.range.length)
            generatedMolecules.insert(molecule.stringByReplacingCharactersInRange(range, withString: r[1]))
        }
    }
    return Array(generatedMolecules)
}

print("Task 1: \(replace(molecule).count)")

// reverse search:
var step = 1
var generatedMolecules = Set<String>([molecule])
repeat {
    var newGeneratedMolecules = Set<String>()
    for molecule in generatedMolecules {
        for r in replacements {
            let reqex = try! NSRegularExpression(pattern: r[1], options: [])
            let matches = reqex.matchesInString(molecule, options: [], range: NSMakeRange(0, molecule.characters.count))
            for m in matches {
                let rangeStart = molecule.startIndex.advancedBy(m.range.location)
                let range = rangeStart..<rangeStart.advancedBy(m.range.length)
                let moleculeReplaced = molecule.stringByReplacingCharactersInRange(range, withString: r[0])
                newGeneratedMolecules.insert(moleculeReplaced)
            }
        }
    }
    if newGeneratedMolecules.count == 0 {
        print("FAIL")
        exit(EXIT_FAILURE)
    }
    generatedMolecules = Set(newGeneratedMolecules.sort { $0.characters.count < $1.characters.count }[0..<min(1,newGeneratedMolecules.count)]) // take n-shortest (lucky guess)
    step += 1
//    print("\(steps): \(generatedMolecules)")
} while !generatedMolecules.reduce(false) { $0 || generatorMolecules.contains($1)}
print("Task 2: \(step)")
