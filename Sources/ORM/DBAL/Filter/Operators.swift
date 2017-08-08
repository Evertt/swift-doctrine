infix operator =~ : ComparisonPrecedence
infix operator !~ : ComparisonPrecedence

public func ==(left: TableColumn, right: NodeRepresentable) -> Filter {
    return .where(left, is: .equalTo, right)
}

public func !=(left: TableColumn, right: NodeRepresentable) -> Filter {
    return .where(left, is: .notEqualTo, right)
}

public func >=(left: TableColumn, right: NodeRepresentable) -> Filter {
    return .where(left, is: .greaterThanOrEqualTo, right)
}

public func <=(left: TableColumn, right: NodeRepresentable) -> Filter {
    return .where(left, is: .lessThanOrEqualTo, right)
}

public func >(left: TableColumn, right: NodeRepresentable) -> Filter {
    return .where(left, is: .greaterThan, right)
}

public func <(left: TableColumn, right: NodeRepresentable) -> Filter {
    return .where(left, is: .lessThan, right)
}

public func =~(left: TableColumn, right: [NodeRepresentable]) -> Filter {
    return .subset(left, in: right)
}

public func !~(left: TableColumn, right: [NodeRepresentable]) -> Filter {
    return !(left =~ right)
}

public func =~(left: TableColumn, right: Filter.Match) -> Filter {
    return .match(left, right)
}

public func !~(left: TableColumn, right: Filter.Match) -> Filter {
    return !(left =~ right)
}

public func =~<T: NodeRepresentable>(left: TableColumn, right: CountableRange<T>) -> Filter {
    let lowerBound = try! right.lowerBound.makeNode()
    let upperBound = try! right.upperBound.makeNode()
    
    return left >= lowerBound && left < upperBound
}

public func !~<T: NodeRepresentable>(left: TableColumn, right: CountableRange<T>) -> Filter {
    return !(left =~ right)
}

public func =~<T: NodeRepresentable>(left: TableColumn, right: Range<T>) -> Filter {
    let lowerBound = try! right.lowerBound.makeNode()
    let upperBound = try! right.upperBound.makeNode()
    
    return left >= lowerBound && left < upperBound
}

public func !~<T: NodeRepresentable>(left: TableColumn, right: Range<T>) -> Filter {
    return !(left =~ right)
}

public func =~<T: NodeRepresentable>(left: TableColumn, right: CountableClosedRange<T>) -> Filter {
    let lowerBound = try! right.lowerBound.makeNode()
    let upperBound = try! right.upperBound.makeNode()
    
    return left >= lowerBound && left <= upperBound
}

public func !~<T: NodeRepresentable>(left: TableColumn, right: CountableClosedRange<T>) -> Filter {
    return !(left =~ right)
}

public func =~<T: NodeRepresentable>(left: TableColumn, right: ClosedRange<T>) -> Filter {
    let lowerBound = try! right.lowerBound.makeNode()
    let upperBound = try! right.upperBound.makeNode()
    
    return left >= lowerBound && left <= upperBound
}

public func !~<T: NodeRepresentable>(left: TableColumn, right: ClosedRange<T>) -> Filter {
    return !(left =~ right)
}

public func ==(left: String, right: String) -> Filter {
    return .where(TableColumn(left), is: .equalTo, Node(right))
}

public func !=(left: String, right: String) -> Filter {
    return .where(TableColumn(left), is: .notEqualTo, Node(right))
}

public func >=(left: String, right: String) -> Filter {
    return .where(TableColumn(left), is: .greaterThanOrEqualTo, Node(right))
}

public func <=(left: String, right: String) -> Filter {
    return .where(TableColumn(left), is: .lessThanOrEqualTo, Node(right))
}

public func >(left: String, right: String) -> Filter {
    return .where(TableColumn(left), is: .greaterThan, Node(right))
}

public func <(left: String, right: String) -> Filter {
    return .where(TableColumn(left), is: .lessThan, Node(right))
}

public func &&(left: Filter, right: Filter) -> Filter {
    return .both(left, and: right)
}

public func ||(left: Filter, right: Filter) -> Filter {
    return .either(left, or: right)
}

public prefix func !(filter: Filter) -> Filter {
    return .not(filter)
}

prefix  operator *
postfix operator *

public prefix func *(string: String) -> Filter.Match {
    return .endsWith(string)
}

public postfix func *(string: String) -> Filter.Match {
    return .startsWith(string)
}

public prefix func *(match: Filter.Match) -> Filter.Match {
    guard case let .startsWith(string) = match else {
        fatalError()
    }
    
    return .contains(string)
}

public postfix func *(match: Filter.Match) -> Filter.Match {
    guard case let .endsWith(string) = match else {
        fatalError()
    }
    
    return .contains(string)
}
