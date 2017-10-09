extension Filter: CustomStringConvertible {
    var groupedDescription: String {
        switch self {
        case .all, .any:
            return "(\(self))"
        default:
            return "\(self)"
        }
    }

    public var description: String {
        switch self {
        case let .all(filters):
            return filters.map {
               $0.groupedDescription
            }.joined(separator: " AND ")
            
        case let .any(filters):
            return filters.map {
                $0.groupedDescription
            }.joined(separator: " OR ")
            
        case let .not(filter):
            return "NOT \(filter.groupedDescription)"
            
        case let .match(field, match):
            return "\(field) LIKE \(match)"
            
        case let .compare(field, comparison, node):
//            if case .equalTo = comparison, case .null = try! node.makeNode() {
//                return "\(field) IS NULL"
//            }
            
            return "\(field) \(comparison.rawValue) \(node)"
            
        case let .subset(field, nodes):
            return "\(field) IN \(nodes)"
            
        }
    }
    
    var groupedQueryAndValues: (String, [Encodable]) {
        let qv = self.queryAndValues
        
        switch self {
        case .all, .any:
            return ("(\(qv.0))", qv.1)
        default:
            return qv
        }
    }
    
    public var queryAndValues: (String, [Encodable]) {
        switch self {
        case let .all(filters):
            let qv = filters.map { $0.groupedQueryAndValues }
            
            let q = qv.map{$0.0}.joined(separator: " AND ")
            let v = qv.flatMap{$0.1}
            
            return (q, v)
            
        case let .any(filters):
            let qv = filters.map { $0.groupedQueryAndValues }
            
            let q = qv.map{$0.0}.joined(separator: " OR ")
            let v = qv.flatMap{$0.1}
            
            return (q, v)
        case let .not(filter):
            let qv = filter.groupedQueryAndValues
            
            return ("NOT \(qv.0)", qv.1)
            
        case let .match(field, match):
            return ("\(field) LIKE ?", [match.stringWithJoker])
            
        case let .compare(field, comparison, node):
//            if case .equalTo = comparison, case .null = try! node.makeNode() {
//                return ("\(field) IS NULL", [])
//            }
            
            return ("\(field) \(comparison.rawValue) ?", [node])
            
        case let .subset(field, nodes):
            let marks = Array(repeating: "?", count: nodes.count).joined(separator: ", ")
            
            return ("\(field) IN (\(marks))", nodes)
            
        }
    }
}

