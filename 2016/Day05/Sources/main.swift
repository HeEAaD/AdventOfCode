import Foundation
import CryptoSwift

let input = "ffykfhsq"
var password = ""

for i in 0..<UInt.max {
    let md5 = "\(input)\(i)".md5()
    if md5.hasPrefix("00000") {
        password.append(md5[md5.index(md5.startIndex, offsetBy: 5)])
        if password.characters.count >= 8 {
            break
        }
    }
}

print("Task 1: \(password)") // c6697b55

var password2 = Array<Character?>(repeating: nil, count: 8)

for i in 0..<UInt.max {
    let md5 = "\(input)\(i)".md5()
    if md5.hasPrefix("00000") {
        if let position = Int("\(md5[md5.index(md5.startIndex, offsetBy: 5)])"), position < password2.count {
            if password2[position] == nil {
                password2[position] = md5[md5.index(md5.startIndex, offsetBy: 6)]
                if (password2.filter { $0 != nil }.count) >= 8 {
                    break
                }
            }
        }
    }
}

print("Task 2: \(String(password2.map { $0! }))") // 8c35d1ab
