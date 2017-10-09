import Foundation

public final class HasMany<T: Entity, E: Entity> {
    let source: T
    
    lazy var entities: OrderedSet<E> = {
        let manager = self.source.manager
        
        let filter = self.filter.and(self.key == self.source.id)
        
        return OrderedSet(manager.find(where: filter))
    }()
    
    let key: Key<E,ID>
    let filter: Filter<E>
    
    public init<S: Sequence>(source: T, key: Key<E,ID>, filter: Filter<E> = .all([]), entities: S? = nil) where S.Element == E {
        self.key    = key
        self.source = source
        self.filter = filter
        
        if let entities = entities {
            self.entities = OrderedSet(entities)
        }
    }
    
    public func filter(where filter: Filter<E>) -> HasMany<T,E> {
        return HasMany(source: source, key: key, filter: self.filter.and(filter), entities: [E]?.none)
    }
}

extension HasMany: Equatable {
    public static func ==(lhs: HasMany<T,E>, rhs: HasMany<T,E>) -> Bool {
        return lhs.entities == rhs.entities
    }
}

extension HasMany: MutableCollection {
    public typealias Index = OrderedSet<E>.Index
    
    public var startIndex: Index {
        return entities.startIndex
    }
    
    public var endIndex: Index {
        return entities.endIndex
    }
    
    public subscript(i: Index) -> E {
        get {
            return entities[i]
        }
        
        set {
            setForeignKey(on: newValue)
            entities[i] = newValue
        }
    }
    
    public func index(after i: Index) -> Index {
        return entities.index(after: i)
    }
}

extension HasMany {
    public static func +(left: HasMany<T,E>, right: E) -> HasMany<T,E> {
        var result = HasMany(source: left.source, key: left.key, filter: left.filter, entities: left.entities)
        result += right
        return result
    }
    
    public static func +=(left: inout HasMany<T,E>, right: E) {
        left.append(right)
    }
    
    public static func +<S: Sequence>(left: HasMany<T,E>, right: S) -> HasMany<T,E> where S.Iterator.Element == E {
        var result = HasMany(source: left.source, key: left.key, filter: left.filter, entities: left.entities)
        result += right
        return result
    }
    
    public static func +=<S: Sequence>(left: inout HasMany<T,E>, right: S) where S.Iterator.Element == E {
        right.forEach { left.append($0) }
    }
    
    public static func -(left: HasMany<T,E>, right: E) -> HasMany<T,E> {
        var result = HasMany(source: left.source, key: left.key, filter: left.filter, entities: left.entities)
        result -= right
        return result
    }
    
    public static func -=(left: inout HasMany<T,E>, right: E) {
        left.remove(right)
    }
    
    public static func -<S: Sequence>(left: HasMany<T,E>, right: S) -> HasMany<T,E> where S.Iterator.Element == E {
        var result = HasMany(source: left.source, key: left.key, filter: left.filter, entities: left.entities)
        result -= right
        return result
    }
    
    public static func -=<S: Sequence>(left: inout HasMany<T,E>, right: S) where S.Iterator.Element == E {
        right.forEach { left.remove($0) }
    }
}

extension HasMany {
    public var isEmpty: Bool {
        return entities.isEmpty
    }
    
    public var count: Int {
        return entities.count
    }
    
    public func contains(_ member: E) -> Bool {
        return entities.contains(member)
    }
    
    public func append(_ newMember: E) {
        setForeignKey(on: newMember)
        entities.append(newMember)
    }
    
    public func insert(_ newMember: E, at index: Index) {
        setForeignKey(on: newMember)
        entities.insert(newMember, at: index)
    }
    
    func unsetForeignKey(on entity: E) {
        var entity = entity
        try! ReflectionExtensions.set(E??.some(.none) as Any, key: "\(key).storage", for: &entity)
    }
    
    func setForeignKey(on entity: E) {
        var entity = entity
        let key = self.key.stringValue.replacingOccurrences(of: "id", with: "storage")
        try! ReflectionExtensions.set(source, key: key, for: &entity)
    }
    
    public func remove(_ member: E) {
        if let entity = get("\(key)", from: member)?.value as? T, entity === source {
            unsetForeignKey(on: member)
        }
        
        entities.remove(member)
    }
}

public protocol EntityCollection {}

extension HasMany: EntityCollection {}


