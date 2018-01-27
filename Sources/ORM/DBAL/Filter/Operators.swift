infix operator =~ : ComparisonPrecedence
infix operator !~ : ComparisonPrecedence

public func ==<E, T: Encodable>(left: Key<E,T>, right: T) -> Filter<E> where T: Equatable {
    return .where(left, equalTo: right)
}

public func ==<E, T: Encodable>(left: Key<E,T?>, right: T?) -> Filter<E> where T: Equatable {
    return .where(left, equalTo: right)
}

public func !=<E, T: Encodable>(left: Key<E,T>, right: T) -> Filter<E> where T: Equatable {
    return .where(left, notEqualTo: right)
}

public func !=<E, T: Encodable>(left: Key<E,T?>, right: T?) -> Filter<E> where T: Equatable {
    return .where(left, notEqualTo: right)
}

public func >=<E, T: Encodable>(left: Key<E,T>, right: T) -> Filter<E> where T: Comparable {
    return .where(left, is: .greaterThanOrEqualTo, right)
}

public func <=<E, T: Encodable>(left: Key<E,T>, right: T) -> Filter<E> where T: Comparable {
    return .where(left, is: .lessThanOrEqualTo, right)
}

public func ><E, T: Encodable>(left: Key<E,T>, right: T) -> Filter<E> where T: Comparable {
    return .where(left, is: .greaterThan, right)
}

public func <<E, T: Encodable>(left: Key<E,T>, right: T) -> Filter<E> where T: Comparable {
    return .where(left, is: .lessThan, right)
}

public func =~<E, T: Encodable>(left: Key<E,T>, right: [T]) -> Filter<E> {
    return .subset(left, in: right)
}

public func !~<E, T: Encodable>(left: Key<E,T>, right: [T]) -> Filter<E> {
    return !(left =~ right)
}

public func =~<E>(left: Key<E,String>, right: Filter<E>.Match) -> Filter<E> {
    return .match(left, right)
}

public func !~<E>(left: Key<E,String>, right: Filter<E>.Match) -> Filter<E> {
    return !(left =~ right)
}

public func =~<E, T: Encodable>(left: Key<E,T>, right: CountableRange<T>) -> Filter<E> {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound
    
    return left >= lowerBound && left < upperBound
}

public func !~<E, T: Encodable>(left: Key<E,T>, right: CountableRange<T>) -> Filter<E> {
    return !(left =~ right)
}

public func =~<E, T: Encodable>(left: Key<E,T>, right: Range<T>) -> Filter<E> {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound
    
    return left >= lowerBound && left < upperBound
}

public func !~<E, T: Encodable>(left: Key<E,T>, right: Range<T>) -> Filter<E> {
    return !(left =~ right)
}

public func =~<E, T: Encodable>(left: Key<E,T>, right: CountableClosedRange<T>) -> Filter<E> {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound
    
    return left >= lowerBound && left <= upperBound
}

public func !~<E, T: Encodable>(left: Key<E,T>, right: CountableClosedRange<T>) -> Filter<E> {
    return !(left =~ right)
}

public func =~<E, T: Encodable>(left: Key<E,T>, right: ClosedRange<T>) -> Filter<E> {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound
    
    return left >= lowerBound && left <= upperBound
}

public func !~<E, T: Encodable>(left: Key<E,T>, right: ClosedRange<T>) -> Filter<E> {
    return !(left =~ right)
}

public func &&<E>(left: Filter<E>, right: Filter<E>) -> Filter<E> {
    return .both(left, and: right)
}

public func ||<E>(left: Filter<E>, right: Filter<E>) -> Filter<E> {
    return .either(left, or: right)
}

public prefix func !<E>(filter: Filter<E>) -> Filter<E> {
    return .not(filter)
}

prefix  operator *
postfix operator *

public prefix func *<E>(string: String) -> Filter<E>.Match {
    return .endsWith(string)
}

public postfix func *<E>(string: String) -> Filter<E>.Match {
    return .startsWith(string)
}

public prefix func *<E>(match: Filter<E>.Match) -> Filter<E>.Match {
    guard case let .startsWith(string) = match else {
        fatalError()
    }
    
    return .contains(string)
}

public postfix func *<E>(match: Filter<E>.Match) -> Filter<E>.Match {
    guard case let .endsWith(string) = match else {
        fatalError()
    }
    
    return .contains(string)
}

