infix operator =~ : ComparisonPrecedence
infix operator !~ : ComparisonPrecedence

public func ==<K: TypedCodingKey, T: Encodable>(left: K, right: T) -> Filter where K.Wrapped: Equatable, K.Wrapped == T {
    return .where(left, equalTo: right)
}

public func !=<K: TypedCodingKey, T: Encodable>(left: K, right: T) -> Filter where K.Wrapped: Equatable, K.Wrapped == T {
    return .where(left, notEqualTo: right)
}

public func >=<K: TypedCodingKey, T: Encodable>(left: K, right: T) -> Filter where K.Wrapped: Comparable, K.Wrapped == T {
    return .where(left, is: .greaterThanOrEqualTo, right)
}

public func <=<K: TypedCodingKey, T: Encodable>(left: K, right: T) -> Filter where K.Wrapped: Comparable, K.Wrapped == T {
    return .where(left, is: .lessThanOrEqualTo, right)
}

public func ><K: TypedCodingKey, T: Encodable>(left: K, right: T) -> Filter where K.Wrapped: Comparable, K.Wrapped == T {
    return .where(left, is: .greaterThan, right)
}

public func <<K: TypedCodingKey, T: Encodable>(left: K, right: T) -> Filter where K.Wrapped: Comparable, K.Wrapped == T {
    return .where(left, is: .lessThan, right)
}

public func =~<K: TypedCodingKey, T: Encodable>(left: K, right: [T]) -> Filter where K.Wrapped == T {
    return .subset(left, in: right)
}

public func !~<K: TypedCodingKey, T: Encodable>(left: K, right: [T]) -> Filter where K.Wrapped == T {
    return !(left =~ right)
}

public func =~<K: TypedCodingKey>(left: K, right: Filter.Match) -> Filter where K.Wrapped == String {
    return .match(left, right)
}

public func !~<K: TypedCodingKey>(left: K, right: Filter.Match) -> Filter where K.Wrapped == String {
    return !(left =~ right)
}

public func =~<K: TypedCodingKey, T: Encodable>(left: K, right: CountableRange<T>) -> Filter where K.Wrapped == T {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound

    return left >= lowerBound && left < upperBound
}

public func !~<K: TypedCodingKey, T: Encodable>(left: K, right: CountableRange<T>) -> Filter where K.Wrapped == T {
    return !(left =~ right)
}

public func =~<K: TypedCodingKey, T: Encodable>(left: K, right: Range<T>) -> Filter where K.Wrapped == T {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound

    return left >= lowerBound && left < upperBound
}

public func !~<K: TypedCodingKey, T: Encodable>(left: K, right: Range<T>) -> Filter where K.Wrapped == T {
    return !(left =~ right)
}

public func =~<K: TypedCodingKey, T: Encodable>(left: K, right: CountableClosedRange<T>) -> Filter where K.Wrapped == T {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound

    return left >= lowerBound && left <= upperBound
}

public func !~<K: TypedCodingKey, T: Encodable>(left: K, right: CountableClosedRange<T>) -> Filter where K.Wrapped == T {
    return !(left =~ right)
}

public func =~<K: TypedCodingKey, T: Encodable>(left: K, right: ClosedRange<T>) -> Filter where K.Wrapped == T {
    let lowerBound = right.lowerBound
    let upperBound = right.upperBound

    return left >= lowerBound && left <= upperBound
}

public func !~<K: TypedCodingKey, T: Encodable>(left: K, right: ClosedRange<T>) -> Filter where K.Wrapped == T {
    return !(left =~ right)
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

