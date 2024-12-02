let lines = input.split(whereSeparator: \.isNewline)
let reports: [[Int]] = lines.map { $0.split(separator: " ").map { Int($0)! } }

var safeCount: Int = 0
var safeCountFixed: Int = 0

for report in reports {
    if isSafe(report) {
        safeCount += 1
    } else {
        for i in 0..<report.count {
            var fixedReport = report
            fixedReport.removeSubrange(i...i)
            if isSafe(fixedReport) {
                safeCountFixed += 1
                break
            }
        }
    }
}

print("Answer 1:", safeCount)
print("Answer 2:", safeCount + safeCountFixed)

func isSafe(_ report: [Int]) -> Bool {
    let isIncreasing = report[1] - report[0] > 0
    for i in 1..<report.count {
        let difference = report[i] - report[i - 1]
        if difference == 0
            || (difference > 0) != isIncreasing
            || abs(difference) > 3
        {
            return false
        }
    }
    return true
}
