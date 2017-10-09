import Foundation

public indirect enum Filter<E: Entity> {
    case not(Filter<E>)
    case any([Filter<E>])
    case all([Filter<E>])
    
    case match(CodingKey, Match)
    case subset(CodingKey, in: [Encodable])
    case compare(CodingKey, is: Comparison, Encodable)
}
