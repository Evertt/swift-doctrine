extension Sequence {
    func map<Key: Hashable, Value>(transform: (Iterator.Element) throws -> (Key, Value)) rethrows -> [Key:Value] {
        var dict = [Key:Value]()
        
        for element in self {
            let result = try transform(element)
            dict[result.0] = result.1
        }
        
        return dict
    }
}

extension Dictionary {
    static func +=( lhs: inout [Key:Value], rhs: [Key:Value]) {
        for (key, value) in rhs {
            lhs[key] = value
        }
    }
}
