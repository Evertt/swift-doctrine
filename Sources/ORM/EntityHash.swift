struct EntityHash: Hashable {
    let hashValue: Int
    
    init<E: _Entity>(_ object: E) {
        hashValue = "\(type(of: object))".hashValue
    }
    
    init<E: _Entity>(_ type: E.Type) {
        hashValue = "\(type)".hashValue
    }
    
    static func ==(lhs: EntityHash, rhs: EntityHash) -> Bool {
        return lhs.hashValue == rhs.hashValue
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

extension Entity {
    public var hashValue: Int {
        return hash.hashValue
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.hash == rhs.hash
    }
}
