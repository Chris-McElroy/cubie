//
//  Alg.swift
//  cubie
//
//  Created by chris on '26.1.2.
//

class Alg {
    let alg: [Move]
    
    init(_ alg: [Move]) {
        self.alg = alg
    }
    
    init?(_ string: String) {
        var alg: [Move] = []
        let moveStrings = string.split(separator: " ")
        for moveString in moveStrings {
            guard let move = Move(String(moveString)) else { return nil }
            alg.append(move)
        }
        self.alg = alg
    }
    
    var string: String {
        alg.map { $0.string }.joined(separator: " ")
    }
    
    var inverse: Alg {
        Alg(alg.map { $0.inverse }.reversed())
    }
}

struct Move {
    let main: (face: Face, dir: Dir)
    let pre: (face: Face, dir: Dir)?
    
    init(_ face: Face, _ dir: Dir) {
        self.main = (face: face, dir: dir)
        self.pre = nil
    }
    
    init(pre: (face: Face, dir: Dir), main: (face: Face, dir: Dir)) {
        self.pre = pre
        self.main = main
    }
    
    init?(_ string: String) {
        let moveStrings = string.split(separator: "").map { String($0) }
        switch moveStrings.count {
        case 1:
            guard let mainFace = Face(rawValue: moveStrings[0]) else { return nil }
            main = (face: mainFace, dir: Dir.right)
            pre = nil
        case 2:
            if let mainDir = Dir(rawValue: String(moveStrings[1])) {
                guard let mainFace = Face(rawValue: moveStrings[0]) else { return nil }
                main = (face: mainFace, dir: mainDir)
                pre = nil
            } else {
                guard let mainFace = Face(rawValue: moveStrings[1]) else { return nil }
                guard let preFace = Face(rawValue: moveStrings[0]) else { return nil }
                main = (face: mainFace, dir: Dir.right)
                pre = (face: preFace, dir: Dir.right)
            }
        case 3:
            if let mainDir = Dir(rawValue: String(moveStrings[2])) {
                guard let mainFace = Face(rawValue: moveStrings[1]) else { return nil }
                guard let preFace = Face(rawValue: moveStrings[0]) else { return nil }
                main = (face: mainFace, dir: mainDir)
                pre = (face: preFace, dir: Dir.right)
            } else {
                guard let mainFace = Face(rawValue: moveStrings[2]) else { return nil }
                guard let preFace = Face(rawValue: moveStrings[1]) else { return nil }
                guard let preDir = Dir(rawValue: moveStrings[0]) else { return nil }
                main = (face: mainFace, dir: Dir.right)
                pre = (face: preFace, dir: preDir)
            }
        case 4:
            guard let mainFace = Face(rawValue: moveStrings[2]) else { return nil }
            guard let mainDir = Dir(rawValue: moveStrings[3]) else { return nil }
            guard let preFace = Face(rawValue: moveStrings[1]) else { return nil }
            guard let preDir = Dir(rawValue: moveStrings[0]) else { return nil }
            main = (face: mainFace, dir: mainDir)
            pre = (face: preFace, dir: preDir)
        default: return nil
        }
    }
    
    var string: String {
        if let pre {
            return (
                pre.dir.preDir + pre.face.rawValue +
                main.face.rawValue + main.dir.rawValue
            )
        } else {
            return main.face.rawValue + main.dir.rawValue
        }
    }
    
    var inverse: Move {
        if let pre {
            return Move(pre: pre, main: (face: main.face, dir: main.dir.inverse))
        } else {
            return Move(main.face, main.dir.inverse)
        }
    }
}

enum Face: String {
    case F = "F", R = "R", L = "L", U = "U", D = "D", B = "B"
    case f = "f", r = "r", l = "l", u = "u", d = "d", b = "b"
    
    case S = "s", E = "e", M = "m"
    case x = "x", y = "y", z = "z"
}

enum Dir: String {
    case right = "", two = "2", left = "'"
    
    init?(rawValue: String) {
        switch rawValue {
        case "": self = .right
        case "'": self = .left
        case ",": self = .left
        case "2": self = .two
        default: return nil
        }
    }
    
    var preDir: String {
        switch self {
        case .right: return ""
        case .left: return ","
        case .two: return "2"
        }
    }
    
    var inverse: Dir {
        switch self {
        case .right: return .left
        case .left: return .right
        case .two: return .two
        }
    }
}
