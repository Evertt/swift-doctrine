infix operator =~ : ComparisonPrecedence
infix operator !~ : ComparisonPrecedence

public func ==<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: T) -> Filter<K.Start> where K.Wrapped == T, T: Equatable {
    return .where(left, equalTo: right)
}

public func ==<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: T?) -> Filter<K.Start> where K.Wrapped == T?, T: Equatable {
    return .where(left, equalTo: right)
}

public func !=<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: T) -> Filter<K.Start> where K.Wrapped == T, T: Equatable {
    return .where(left, notEqualTo: right)
}

public func !=<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: T?) -> Filter<K.Start> where K.Wrapped == T?, T: Equatable {
    return .where(left, notEqualTo: right)
}

public func >=<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: T) -> Filter<K.Start> where K.Wrapped == T, T: Comparable {
    return .where(left, is: .greaterThanOrEqualTo, right)
}

public func <=<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: T) -> Filter<K.Start> where K.Wrapped == T, T: Comparable {
    return .where(left, is: .lessThanOrEqualTo, right)
}

public func ><K: DoublyTypedCodingKey, T: Encodable>(left: K, right: T) -> Filter<K.Start> where K.Wrapped == T, T: Comparable {
    return .where(left, is: .greaterThan, right)
}

public func <<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: T) -> Filter<K.Start> where K.Wrapped == T, T: Comparable {
    return .where(left, is: .lessThan, right)
}

public func =~<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: [T]) -> Filter<K.Start> where K.Wrapped == T {
    return .subset(left, in: right)
}

public func !~<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: [T]) -> Filter<K.Start> where K.Wrapped == T {
    return !(left =~ right)
}

public func =~<K: DoublyTypedCodingKey>(left: K, right: Filter<K.Start>.Match) -> Filter<K.Start> where K.Wrapped == String {
    return .match(left, right)
}

public func !~<K: DoublyTypedCodingKey>(left: K, right: Filter<K.Start>.Match) -> Filter<K.Start> where K.Wrapped == String {
    return !(left =~ right)
}

public func =~<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: CountableRange<T>) -> Filter<K.Start> where K.Wrapped == T {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound
    
    return left >= lowerBound && left < upperBound
}

public func !~<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: CountableRange<T>) -> Filter<K.Start> where K.Wrapped == T {
    return !(left =~ right)
}

public func =~<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: Range<T>) -> Filter<K.Start> where K.Wrapped == T {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound
    
    return left >= lowerBound && left < upperBound
}

public func !~<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: Range<T>) -> Filter<K.Start> where K.Wrapped == T {
    return !(left =~ right)
}

public func =~<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: CountableClosedRange<T>) -> Filter<K.Start> where K.Wrapped == T {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound
    
    return left >= lowerBound && left <= upperBound
}

public func !~<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: CountableClosedRange<T>) -> Filter<K.Start> where K.Wrapped == T {
    return !(left =~ right)
}

public func =~<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: ClosedRange<T>) -> Filter<K.Start> where K.Wrapped == T {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound
    
    return left >= lowerBound && left <= upperBound
}

public func !~<K: DoublyTypedCodingKey, T: Encodable>(left: K, right: ClosedRange<T>) -> Filter<K.Start> where K.Wrapped == T {
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

