import Foundation

public class HasMany<E: Entity>: MutableCollection {
    let source: Entity
    
    lazy var entities: [E] = {
        let manager = self.source.manager
        
        let foreignKey = TableColumn(self.key)
        
        let filter = self.filter.and(foreignKey == self.source.id)
        
        return manager.find(where: filter)
    }()
    
    let key: String
    let filter: Filter
    
    public var startIndex : Int { return entities.startIndex }
    public var endIndex   : Int { return entities.endIndex   }
    
    public init(source: Entity, key: String, filter: Filter = .all([]), entities: [E]? = nil) {
        self.key    = key
        self.source = source
        self.filter = filter
        
        if let entities = entities {
            self.entities = entities
        }
    }
    
    public subscript(i: Int) -> E {
        get { return entities[i]     }
        set { entities[i] = newValue }
    }
    
    public func index(after i: Int) -> Int {
        guard i != endIndex else {
            fatalError("Cannot increment endIndex")
        }
        
        return i + 1
    }
    
    public func filter(where filter: Filter) -> HasMany {
        return HasMany(source: source, key: key, filter: self.filter.and(filter))
    }
    
    public func append(_ entity: E) {
        var entity = entity
        try! ReflectionExtensions.set(source, key: "\(key).storage", for: &entity)
        entities.append(entity)
    }
    
    public func append<S: Sequence>(contentsOf sequence: S) where S.Iterator.Element == E {
        sequence.forEach { entity in self.append(entity) }
    }
    
    public static func +(left: HasMany<E>, right: E) -> HasMany<E> {
        let result = HasMany(source: left.source, key: left.key, filter: left.filter, entities: left.entities)
        result.append(right)
        return result
    }
    
    public static func +=(left: inout HasMany<E>, right: E) {
        left.append(right)
    }
    
    public static func +<S: Sequence>(left: HasMany<E>, right: S) -> HasMany<E> where S.Iterator.Element == E {
        let result = HasMany(source: left.source, key: left.key, filter: left.filter, entities: left.entities)
        result.append(contentsOf: right)
        return result
    }
    
    public static func +=<S: Sequence>(left: inout HasMany<E>, right: S) where S.Iterator.Element == E {
        left.append(contentsOf: right)
    }
}

extension HasMany: NodeRepresentable {
    public func makeNode(in context: Context?) throws -> Node {
        return Node(entities.map{$0.id})
    }
}

public protocol EntityCollection {
    func map<T>(_ transform: (Entity) throws -> T) rethrows -> [T]
}

extension HasMany: EntityCollection {
    public func map<T>(_ transform: (Entity) throws -> T) rethrows -> [T] {
        return try map { (entity: E) -> T in try transform(entity) }
    }
}
