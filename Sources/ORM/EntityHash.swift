struct EntityHash: Hashable {
    let base: Any.Type
    
    init<E: _Entity>(_ object: E) {
        base = E.self
    }
    
    init<E: _Entity>(_ type: E.Type) {
        base = E.self
    }
    
    func hash(into hasher: inout Hasher) {
        return ObjectIdentifier(base).hash(into: &hasher)
    }
    
    static func ==(lhs: EntityHash, rhs: EntityHash) -> Bool {
        return lhs.base == rhs.base
    }
}

extension _Entity {
    static var hash: EntityHash {
        return EntityHash(Self.self)
    }
    
    var hash: EntityHash {
        return EntityHash(self)
    }
}

public extension Entity {
    func hash(into hasher: inout Hasher) {
        return hash.hash(into: &hasher)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.hash == rhs.hash
    }
}
