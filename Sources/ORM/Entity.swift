public protocol _Entity: class, Codable {
    var id: ID { get }
}

public protocol Entity: _Entity, Hashable {
    static var id: Key<Self,ID> { get }
}

enum IDCodingKey: String, CodingKey {
    case id
}

extension Key where V: _Entity {
    var id: Key<E,ID> {
        return Key<E,ID>("\(stringValue).id")
    }
}

extension _Entity {
    static var manager: Manager {
        guard let manager = Manager.instances[hash] else {
            fatalError("\(Self.self) was not registered with Doctrine.")
        }
        
        return manager
    }
    
    public static var type: String {
        return "\(Self.self)"
    }
    
    var manager: Manager {
        return Self.manager
    }
    
    var type: String {
        return Self.type
    }
    
    var originalRow: Node? {
        return manager.originals[hash]?[id]
    }
}

extension Entity {
    public func belongsTo<E: Entity>(_ entityType: E.Type, mappedBy key: String? = nil) -> E? {
        let key = key ?? entityType.type.lowercasingFirstLetter()
        
        let _foreignKey: UInt? = originalRow?[key].map {_ in fatalError()}
        
        guard let foreignKey = _foreignKey else {
            return nil
        }
        
        return manager.find(where: E.id == ID(foreignKey))
    }
    
    public func belongsTo<E: Entity>(_ entityType: E.Type, mappedBy key: String? = nil) -> E {
        return belongsTo(entityType, mappedBy: key)!
    }
    
    public func hasMany<E: Entity>(_ entityType: E.Type, reversedBy key: String? = nil) -> HasMany<Self, E> {
        let key = key ?? type.lowercasingFirstLetter()
        
        return HasMany<Self, E>(source: self, key: Key<E,ID>("\(key).id"), filter: .all([]), entities: [E]?.none)
    }
}

extension String {
    func lowercasingFirstLetter() -> String {
        let first = prefix(1).lowercased()
        let other = dropFirst()
        return first + other
    }
    
    mutating func lowercaseFirstLetter() {
        self = self.lowercasingFirstLetter()
    }
}
