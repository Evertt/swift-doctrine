public protocol TypedCodingKey: CodingKey {
    associatedtype Wrapped
    
    init(_ stringValue: String)
}

public extension TypedCodingKey {
    var intValue: Int? {
        return nil
    }
    
    init?(stringValue: String) {
        self.init(stringValue)
    }
    
    init?(intValue: Int) {
        return nil
    }
}

public struct Key<V>: TypedCodingKey {
    public typealias Wrapped = V
    public let stringValue: String
    
    public init(_ stringValue: String) {
        self.stringValue = stringValue
    }
}

public struct RelationKey<V>: TypedCodingKey {
    public typealias Wrapped = V
    public let stringValue: String
    public let filter: Filter
    public let count: Key<Int>
    
    public init(_ stringValue: String) {
        self = RelationKey<V>(stringValue, filter: nil)
    }
    
    public init(_ stringValue: String, filter: Filter?) {
        self.stringValue = stringValue
        self.filter      = filter ?? .all([])
        self.count       = Key<Int>("COUNT(\(stringValue))")
    }
    
    public func filter(_ filter: Filter) -> RelationKey<V> {
        return RelationKey<V>(stringValue, filter: self.filter.and(filter))
    }
}

extension Key: CustomStringConvertible {
    public var description: String {
        return stringValue
    }
}
