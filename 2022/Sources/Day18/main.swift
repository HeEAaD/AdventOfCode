struct Voxel: Hashable {
    let x, y, z: Int
}

let lavaVoxels = Set(
    input.split(whereSeparator: \.isNewline).map { line in
        let components = line.split(separator: ",")
        return Voxel(
            x: Int(components[0])!,
            y: Int(components[1])!,
            z: Int(components[2])!
        )
    }
)

func adjacentVoxels(of voxel: Voxel) -> [Voxel] {
    [
        Voxel(x: voxel.x - 1, y: voxel.y, z: voxel.z),
        Voxel(x: voxel.x + 1, y: voxel.y, z: voxel.z),
        Voxel(x: voxel.x, y: voxel.y - 1, z: voxel.z),
        Voxel(x: voxel.x, y: voxel.y + 1, z: voxel.z),
        Voxel(x: voxel.x, y: voxel.y, z: voxel.z - 1),
        Voxel(x: voxel.x, y: voxel.y, z: voxel.z + 1)
    ]
}

var surfaceArea = 0
for lavaVoxel in lavaVoxels {
    for adjacentVoxel in adjacentVoxels(of: lavaVoxel) where !lavaVoxels.contains(adjacentVoxel) {
        surfaceArea += 1
    }
}

print("Answer 1:", surfaceArea)

var minX = Int.max
var maxX = Int.min
var minY = Int.max
var maxY = Int.min
var minZ = Int.max
var maxZ = Int.min

for voxel in lavaVoxels {
    minX = min(minX, voxel.x)
    maxX = max(maxX, voxel.x)
    minY = min(minY, voxel.y)
    maxY = max(maxY, voxel.y)
    minZ = min(minZ, voxel.z)
    maxZ = max(maxZ, voxel.z)
}

var outerVoxels = Set([Voxel(x: minX - 1, y: minY - 1, z: minZ - 1)])
var edgeVoxels = outerVoxels
var newEdgeVoxels: Set<Voxel>
repeat {
    newEdgeVoxels = []
    for edgeVoxel in edgeVoxels {
        adjacentVoxels(of: edgeVoxel)
            .filter {
                $0.x >= minX - 1 &&
                $0.y >= minY - 1 &&
                $0.z >= minZ - 1 &&
                $0.x <= maxX + 1 &&
                $0.y <= maxY + 1 &&
                $0.z <= maxZ + 1 &&
                !lavaVoxels.contains($0) &&
                !outerVoxels.contains($0) &&
                !newEdgeVoxels.contains($0)
            }.forEach {
                newEdgeVoxels.insert($0)
                outerVoxels.insert($0)
            }
    }
    edgeVoxels = newEdgeVoxels
} while !newEdgeVoxels.isEmpty

var outerSurfaceArea = 0
for voxel in lavaVoxels {
    for adjacentVoxel in adjacentVoxels(of: voxel) where outerVoxels.contains(adjacentVoxel) {
        outerSurfaceArea += 1
    }
}

print("Answer 2:", outerSurfaceArea)
