enum DiskBlock: Equatable {
    case empty
    case file(Int)
}

struct File: Hashable {
    let id: Int
    let size: Int
    var startBlock: Int
}

let inputNumbers = input.map { Int(String($0))! }

var disk: [DiskBlock] = []
var freeSpaces: [Range<Int>] = []
var files: [File] = []

for i in 0..<inputNumbers.count {
    if i.isMultiple(of: 2) {
        files.append(File(id: i/2, size: inputNumbers[i], startBlock: disk.count))
        disk.append(contentsOf: Array(repeating: .file(i/2), count: inputNumbers[i]))
    } else if inputNumbers[i] > 0 {
        freeSpaces.append(disk.count..<disk.count + inputNumbers[i])
        disk.append(contentsOf: Array(repeating: .empty, count: inputNumbers[i]))
    }
}

print("Answer 1:", formatDisk1Checksum(disk: disk))
print("Answer 2:", formatDisk2Checksum(files: files, freeSpaces: freeSpaces))

// MARK: - Methods

func formatDisk1Checksum(disk: [DiskBlock]) -> Int64 {
    var disk = disk
    var firstEmptyIndex = disk.firstIndex(where: { $0 == .empty })!
    outer: while true {
        while true {
            if case let .file(id) = disk.removeLast() {
                if firstEmptyIndex >= disk.count {
                    disk.append(.file(id))
                    break outer
                }
                disk[firstEmptyIndex] = .file(id)
                break
            }
        }

        for i in firstEmptyIndex..<disk.count {
            if disk[i] == .empty {
                firstEmptyIndex = i
                break
            }
        }
    }

    var checksum: Int64 = 0
    for i in disk.indices {
        guard case let .file(id) = disk[i] else { fatalError() }
        checksum += Int64(id) * Int64(i)
    }
    return checksum
}

func formatDisk2Checksum(files: [File], freeSpaces: [Range<Int>]) -> Int64 {
    var freeSpaces = freeSpaces.sorted(by: { $0.startIndex < $1.startIndex })
    var files = files

    for i in files.indices.reversed() {
        if let freeSpaceIndex = freeSpaces.firstIndex(where: { $0.count >= files[i].size }) {
            let freeSpaceRange = freeSpaces[freeSpaceIndex]

            guard freeSpaceRange.lowerBound < files[i].startBlock else { continue }

            files[i].startBlock = freeSpaces[freeSpaceIndex].startIndex

            if freeSpaceRange.count > files[i].size {
                freeSpaces[freeSpaceIndex] = freeSpaceRange.startIndex + files[i].size..<freeSpaceRange.endIndex
            } else {
                freeSpaces.remove(at: freeSpaceIndex)
            }
        }
    }

    var checksum: Int64 = 0
    for file in files.sorted(by: { $0.startBlock < $1.startBlock }) {
        for i in file.startBlock..<file.startBlock + file.size {
            checksum += Int64(file.id) * Int64(i)
        }
    }
    return checksum
}
