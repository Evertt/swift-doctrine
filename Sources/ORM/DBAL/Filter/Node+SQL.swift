//extension Node {
//    var sql: String? {
//        switch self {
//        
//        case .null:
//            return "NULL"
//            
//        case let .string(str):
//            return "\'\(str.replacingOccurrences(of: "'", with: "\\'"))'"
//            
//        case let .number(number):
//            return "\(number)"
//            
//        case let .bool(bool):
//            return "\(bool)"
//            
//        case let .array(nodes):
//            return "(" + nodes.map { $0.sql! }.joined(separator: ", ") + ")"
//            
//        case let .bytes(bytes):
//            return "X'" + bytes.map { String(Int($0), radix: 16) }.joined() + "'"
//        
//        case .object:
//            return nil
//        }
//    }
//}
