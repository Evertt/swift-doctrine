public protocol Entity {
    var id: ID { get }
}

extension Entity {
    static var manager: Manager {
        guard let manager = Manager.instances[hash] else {
            fatalError("\(Self.self) was not registered with Doctrine.")
        }
        
        return manager
    }
    
    static var dummy: Self {
        return manager.factories[hash]!() as! Self
    }
    
    static var type: String {
        return "\(Self.self)"
    }
    
    var manager: Manager {
        return Self.manager
    }
    
    var dummy: Self {
        return Self.dummy
    }
    
    var type: String {
        return Self.type
    }
    
    var originalRow: Node? {
        return manager.originals[hash]?[id]
    }
    
    var key: Key {
        return Key(for: self)
    }
}

extension Entity {
    static func initFromDB(row: [String:Node]) -> Self {
        var dummy = self.dummy
        
        for (key, propertyType) in properties(Self.self) {
            guard let value = row[key] else { continue }
            
            if let nodeInitializable = propertyType.type as? NodeInitializable.Type {
                try! set(nodeInitializable.init(node: value), key: key, for: &dummy)
            }
        }
        
        return dummy
    }
    
    func makeNodeForDB(dontAdd blacklist: inout Set<Key>) -> Node {
        guard !blacklist.contains(key) else {
            return id.makeNode()
        }
        
        blacklist.insert(key)
        
        return Node(properties(self).map { key, property in (
            key,
            propertyToNode(
                property: property,
                dontAdd: &blacklist
            )
        )})
    }
    
    func propertyToNode(property: Property, dontAdd blacklist: inout Set<Key>) -> Node {
        if property.isRelationship {
            if property.isInitialized {
                return Node(property.value, dontAdd: &blacklist)
            } else {
                return Node(originalRow?[property.key])
            }
        }
        
        if property.isNodeConvertible {
            return Node(property.value)
        }
        
        return ""
    }
}

extension Entity {
    public func belongsTo<E: Entity>(_ entityType: E.Type, mappedBy key: String? = nil) -> E? {
        let key = key ?? entityType.type.lowercasingFirstLetter()
        
        guard let foreignKey = originalRow?[key] else {
            return nil
        }
        
        return manager.find(where: "id" == foreignKey)
    }
    
    public func belongsTo<E: Entity>(_ entityType: E.Type, mappedBy key: String? = nil) -> E {
        return belongsTo(entityType, mappedBy: key)!
    }
    
    public func hasMany<E: Entity>(_ entityType: E.Type, reversedBy key: String? = nil) -> HasMany<E> {
        let key = key ?? type.lowercasingFirstLetter()
        
        return HasMany<E>(source: self, key: key)
    }
}

extension String {
    func lowercasingFirstLetter() -> String {
        let first = String(characters.prefix(1)).lowercased()
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func lowercaseFirstLetter() {
        self = self.lowercasingFirstLetter()
    }
}
