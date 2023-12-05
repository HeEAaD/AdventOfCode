import Foundation

let components = input.components(separatedBy: "\n\n")
let seeds = components[0].split(separator: ":")[1].split(separator: " ").map { Int($0)! }

var seedToSoilMap: Map!
var soilToFertilizerMap: Map!
var fertilizerToWaterMap: Map!
var waterToLightMap: Map!
var lightToTemperatureMap: Map!
var temperatureToHumidityMap: Map!
var humidityToLocationMap: Map!

for component in components.dropFirst() {
    let lines = component.split(separator: "\n")
    let title = lines[0]
    switch title {
    case "seed-to-soil map:":
        seedToSoilMap = Map(lines: lines)
    case "soil-to-fertilizer map:":
        soilToFertilizerMap = Map(lines: lines)
    case "fertilizer-to-water map:":
        fertilizerToWaterMap = Map(lines: lines)
    case "water-to-light map:":
        waterToLightMap = Map(lines: lines)
    case "light-to-temperature map:":
        lightToTemperatureMap = Map(lines: lines)
    case "temperature-to-humidity map:":
        temperatureToHumidityMap = Map(lines: lines)
    case "humidity-to-location map:":
        humidityToLocationMap = Map(lines: lines)
    default:
        fatalError()
    }
}

struct Map {
    struct Range {
        let destinationOffset: Int
        let sourceOffset: Int
        let length: Int
    }
    let ranges: [Range]

    init(lines: [Substring]) {
        ranges = lines
            .dropFirst()
            .map {
            let ints = $0.split(separator: " ").map { Int($0)! }
            return Range(
                destinationOffset: ints[0],
                sourceOffset: ints[1],
                length: ints[2]
            )
        }
    }

    func map(source: Int) -> Int {
        guard let range = ranges.first(where: { ($0.sourceOffset..<($0.sourceOffset + $0.length)).contains(source) }) else {
            return source
        }
        return source - range.sourceOffset + range.destinationOffset
    }

    func map(destination: Int) -> Int {
        guard let range = ranges.first(where: { ($0.destinationOffset..<($0.destinationOffset + $0.length)).contains(destination) }) else {
            return destination
        }
        return destination - range.destinationOffset + range.sourceOffset
    }
}

var minLocation = Int.max
for seed in seeds {
    let soil = seedToSoilMap.map(source: seed)
    let fertilizer = soilToFertilizerMap.map(source: soil)
    let water = fertilizerToWaterMap.map(source: fertilizer)
    let light = waterToLightMap.map(source: water)
    let temperature = lightToTemperatureMap.map(source: light)
    let humidity = temperatureToHumidityMap.map(source: temperature)
    let location = humidityToLocationMap.map(source: humidity)
    minLocation = min(minLocation, location)
}

print("Answer 1:", minLocation)

let seedRanges: [Range<Int>] = stride(from: 0, to: seeds.endIndex, by: 2).map {
    seeds[$0]..<seeds[$0] + seeds[$0 + 1]
}

for location in 0..<Int.max {
    let humidity = humidityToLocationMap.map(destination: location)
    let temperature = temperatureToHumidityMap.map(destination: humidity)
    let light = lightToTemperatureMap.map(destination: temperature)
    let water = waterToLightMap.map(destination: light)
    let fertilizer = fertilizerToWaterMap.map(destination: water)
    let soil = soilToFertilizerMap.map(destination: fertilizer)
    let seed = seedToSoilMap.map(destination: soil)
    if seedRanges.contains(where: { $0.contains(seed) }) {
        print("Answer 2:", location)
        break
    }
}
