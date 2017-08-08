struct EntityHash: Hashable {
    let hashValue: Int
    
    init<E: Entity>(_ object: E) {
        hashValue = "\(type(of: object))".hashValue
    }
    
    init<E: Entity>(_ type: E.Type) {
        hashValue = "\(type)".hashValue
    }
    
    static func ==(lhs: EntityHash, rhs: EntityHash) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension Entity {
    static var hash: EntityHash {
        return EntityHash(Self.self)
    }
    
    var hash: EntityHash {
        return EntityHash(self)
    }
}
