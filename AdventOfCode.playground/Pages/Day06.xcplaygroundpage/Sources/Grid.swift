import Foundation

public enum Operation {
    case TurnOn
    case TurnOff
    case Toggle
}

public class Grid {
    
    var lights = Array(count: 1000, repeatedValue: Array(count: 1000, repeatedValue: false))

    public init() {
    }
    
    public func countLightsLit() -> UInt {
        var lightsLit:UInt = 0
        for lightRow in lights {
            for light in lightRow {
                if light {
                    lightsLit++
                }
            }
        }
        return lightsLit
    }
    
    public func operate(var l: String) {
        l = l.stringByReplacingOccurrencesOfString(" through ", withString: ",")
        
        var operation:Operation = .TurnOn
        switch l {
        case l where l.hasPrefix("turn off "):
            l = l.substringFromIndex(l.startIndex.advancedBy(9))
            operation = .TurnOff
        case l where l.hasPrefix("turn on "):
            l = l.substringFromIndex(l.startIndex.advancedBy(8))
            operation = .TurnOn
        case l where l.hasPrefix("toggle "):
            l = l.substringFromIndex(l.startIndex.advancedBy(7))
            operation = .Toggle
        default: break
        }
        
        let comp = l.componentsSeparatedByString(",").map{ Int($0)! }
        operateOnX0(comp[0], y0: comp[1], x1: comp[2], y1: comp[3], operation: operation)
    }
    
    func operateOnX0(x0: Int, y0: Int, x1: Int, y1: Int, operation: Operation) {
        for x in x0...x1 {
            for y in y0...y1 {
                switch operation {
                case .TurnOn: lights[x][y] = true
                case .TurnOff: lights[x][y] = false
                case .Toggle: lights[x][y] = !lights[x][y]
                }
            }
        }
    }
}

public class Grid2 {
    
    var lights = Array(count: 1000, repeatedValue: Array(count: 1000, repeatedValue: UInt(0)))
    
    public init() {
    }
    
    public func countBrightness() -> UInt {
        var brightness:UInt = 0
        for lightRow in lights {
            for light in lightRow {
                brightness += light
            }
        }
        return brightness
    }
    
    public func operate(var l: String) {
        l = l.stringByReplacingOccurrencesOfString(" through ", withString: ",")
        
        var operation:Operation = .TurnOn
        switch l {
        case l where l.hasPrefix("turn off "):
            l = l.substringFromIndex(l.startIndex.advancedBy(9))
            operation = .TurnOff
        case l where l.hasPrefix("turn on "):
            l = l.substringFromIndex(l.startIndex.advancedBy(8))
            operation = .TurnOn
        case l where l.hasPrefix("toggle "):
            l = l.substringFromIndex(l.startIndex.advancedBy(7))
            operation = .Toggle
        default: break
        }
        
        let comp = l.componentsSeparatedByString(",").map{ Int($0)! }
        operateOnX0(comp[0], y0: comp[1], x1: comp[2], y1: comp[3], operation: operation)
    }
    
    func operateOnX0(x0: Int, y0: Int, x1: Int, y1: Int, operation: Operation) {
        for x in x0...x1 {
            for y in y0...y1 {
                switch operation {
                case .TurnOn: lights[x][y]++
                case .TurnOff:
                    if lights[x][y] > 0 {
                        lights[x][y]--
                    }
                case .Toggle: lights[x][y] += 2
                }
            }
        }
    }
}