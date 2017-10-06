import Foundation

public indirect enum Filter {
    case not(Filter)
    case any([Filter])
    case all([Filter])
    
    case match(CodingKey, Match)
    case subset(CodingKey, in: [Encodable])
    case compare(CodingKey, is: Comparison, Encodable)
}
