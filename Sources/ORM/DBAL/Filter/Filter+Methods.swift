extension Filter {
    public static let noFilter: Filter = .all([])
    
    public static func both(_ left: Filter, and right: Filter) -> Filter {
        return left.and(right)
    }
    
    public static func either(_ left: Filter, or right: Filter) -> Filter {
        return left.or(right)
    }
    
    public static func neither(_ left: Filter, nor right: Filter) -> Filter {
        return .not(left.or(right))
    }
    
    public static func `where`<K: TypedCodingKey, T: Encodable>(_ key: K, is comparison: Comparison, _ node: T) -> Filter where K.Wrapped: Comparable, K.Wrapped == T {
        return .compare(key, is: comparison, node)
    }
    
    public static func `where`<K: TypedCodingKey, T: Encodable>(_ key: K, equalTo node: T) -> Filter where K.Wrapped: Equatable, K.Wrapped == T {
        return .compare(key, is: .equalTo, node)
    }
    
    public static func `where`<K: TypedCodingKey, T: Encodable>(_ key: K, notEqualTo node: T) -> Filter where K.Wrapped: Equatable, K.Wrapped == T {
        return .compare(key, is: .notEqualTo, node)
    }
    
    public static func `where`<K: TypedCodingKey, T: Encodable>(_ key: K, in set: [T]) -> Filter where K.Wrapped == T {
        return .subset(key, in: set)
    }
    
    public static func `where`(_ filter: Filter) -> Filter {
        return filter
    }
    
    public static func none(_ filters: [Filter]) -> Filter {
        return .not(.any(filters))
    }
    
    public func and(_ filter: Filter) -> Filter {
        let filters: [Filter]
        
        switch filter {
        case .all(let nestedFilters):
            filters = nestedFilters
        default:
            filters = [filter]
        }
        
        switch self {
        case .all(let nestedFilters):
            return .all(nestedFilters + filters)
        default:
            return .all([self] + filters)
        }
    }
    
    public func or(_ filter: Filter) -> Filter {
        let filters: [Filter]
        
        switch filter {
        case .any(let nestedFilters):
            filters = nestedFilters
        default:
            filters = [filter]
        }
        
        switch self {
        case .any(let nestedFilters):
            return .any(nestedFilters + filters)
        default:
            return .any([self] + filters)
        }
    }
}

