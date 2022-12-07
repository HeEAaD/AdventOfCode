final class Directory {
    let parent: Directory?
    var children: [Directory] = []
    var totalSize = 0

    init(parent: Directory?) {
        self.parent = parent
    }

    func totalSizeSum(maxSize: Int) -> Int {
        var sum = 0
        let totalSize = self.totalSize
        if totalSize <= maxSize {
            sum += totalSize
        }
        for child in children {
            sum += child.totalSizeSum(maxSize: maxSize)
        }
        return sum
    }

    func directoryToDelete(minTotalSize: Int) -> Directory? {
        guard totalSize >= minTotalSize else { return nil }
        let candidates = [self] + children.compactMap {
            $0.directoryToDelete(minTotalSize: minTotalSize)
        }
        return candidates.min { $0.totalSize < $1.totalSize }
    }
}

let rootDirectory = Directory(parent: nil)
var currentDirectory = rootDirectory

for line in input.split(whereSeparator: \.isNewline) {
    if line.hasPrefix("$ cd ") {
        switch line.dropFirst(5) {
        case "/":
            currentDirectory = rootDirectory
        case "..":
            currentDirectory = currentDirectory.parent!
        default:
            let directory = Directory(parent: currentDirectory)
            currentDirectory.children.append(directory)
            currentDirectory = directory
        }
    } else if !line.hasPrefix("$ ls") && !line.hasPrefix("dir") {
        let fileSize = Int(line.split(separator: " ")[0])!
        var directory: Directory? = currentDirectory
        while let _directory = directory {
            _directory.totalSize += fileSize
            directory = _directory.parent
        }
    }
}

print("Answer 1:", rootDirectory.totalSizeSum(maxSize: 100000))

let spaceLeft = 70000000 - rootDirectory.totalSize
let minTotalSize = 30000000 - spaceLeft

print("Answer 2:", rootDirectory.directoryToDelete(minTotalSize: minTotalSize)!.totalSize)
