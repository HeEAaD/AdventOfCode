let width = 25
let height = 6
let inputColors = input.compactMap { Int(String($0)) }

var pixels: [[Int: Int]] = []
var layer = 0
for (i, pixel) in inputColors.enumerated() {
    if pixels.count - 1 < layer {
        pixels.append([:])
    }
    var pixelCount = pixels[layer]
    pixelCount[pixel] = (pixelCount[pixel] ?? 0) + 1
    pixels[layer] = pixelCount
    if i != 0 && i % (width * height) == 0 {
        layer += 1
    }
}

let targetLayerCounts = pixels.min { ($0[0] ?? 0) < ($1[0] ?? 0) }!
print("Part 1: \((targetLayerCounts[1] ?? 0) * (targetLayerCounts[2] ?? 0))")

print("Part 2:")
for j in 0..<height {
    var line = ""
    for i in 0..<width {
        for l in 0..<(inputColors.count / (width * height)) {
            let index = (i + j * width) + (l * width * height)
            let color = inputColors[index]
            if color == 0 {
                line.append(" ")
                break
            } else if color == 1 {
                line.append("#")
                break
            }
        }
    }
    print(line)
}
