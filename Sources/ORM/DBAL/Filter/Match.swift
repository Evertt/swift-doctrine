extension Filter {
    public enum Match {
        case startsWith(String), contains(String), endsWith(String)
    }
}

//extension Filter.Match: CustomStringConvertible {
//    public var description: String {
//        switch self {
//        case let .startsWith(string):
//            return Node(string+"%").sql!
//        case let .contains(string):
//            return Node("%"+string+"%").sql!
//        case let .endsWith(string):
//            return Node("%"+string).sql!
//        }
//    }
//    
//    public var stringWithJoker: String {
//        switch self {
//        case let .startsWith(string):
//            return string+"%"
//        case let .contains(string):
//            return "%"+string+"%"
//        case let .endsWith(string):
//            return "%"+string
//        }
//    }
//}
