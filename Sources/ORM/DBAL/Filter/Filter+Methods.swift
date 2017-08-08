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
    
    public static func `where`(_ key: TableColumn, is comparison: Comparison, _ node: NodeRepresentable) -> Filter {
        return .compare(key, is: comparison, node)
    }
    
    public static func `where`(_ key: TableColumn, in set: [NodeRepresentable]) -> Filter {
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
