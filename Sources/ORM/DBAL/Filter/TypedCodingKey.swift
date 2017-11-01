public protocol SomeCodingKey: CodingKey, Hashable, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    init(_ stringValue: String)
}

public protocol TypedCodingKey: SomeCodingKey {
    associatedtype Wrapped
}

public protocol EntityTypedCodingKey: SomeCodingKey {
    associatedtype Start
}

public protocol DoublyTypedCodingKey: TypedCodingKey, EntityTypedCodingKey {}

public extension SomeCodingKey {
    var intValue: Int? {
        return nil
    }
    
    init?(stringValue: String) {
        self.init(stringValue)
    }
    
    init(stringLiteral value: String) {
        self.init(value)
    }
    
    public init(stringInterpolation strings: Self...) {
        self.init(strings.reduce("") {$0 + $1.stringValue})
    }
    
    public init<T>(stringInterpolationSegment expr: T) {
        self.init("\(expr)")
    }
    
    init?(intValue: Int) {
        return nil
    }
    
    var hashValue: Int {
        return stringValue.hashValue
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.stringValue == rhs.stringValue
    }
}

public struct Key<E,V>: DoublyTypedCodingKey {
    public typealias Start   = E
    public typealias Wrapped = V
    
    public let stringValue: String
    
    public init(_ stringValue: String) {
        self.stringValue = stringValue
    }
}

public struct RelationKey<E: Entity,V: Entity>: DoublyTypedCodingKey {
    public typealias Start   = E
    public typealias Wrapped = V
    
    public let stringValue: String
    public let filter: Filter<V>
    public let count: Key<E,Int>
    
    public init(_ stringValue: String) {
        self = RelationKey<E,V>(stringValue, filter: nil)
    }
    
    public init(_ stringValue: String, filter: Filter<V>?) {
        self.stringValue = stringValue
        self.filter      = filter ?? .all([])
        self.count       = Key<E,Int>("COUNT(\(stringValue))")
    }
    
    public func filter(_ filter: Filter<V>) -> RelationKey<E,V> {
        return RelationKey<E,V>(stringValue, filter: self.filter.and(filter))
    }
}

extension Key: CustomStringConvertible {
    public var description: String {
        return stringValue
    }
}
