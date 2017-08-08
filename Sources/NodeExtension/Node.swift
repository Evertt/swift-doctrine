@_exported import Node
import ReflectionExtensions

public struct Collapsed: Context {public init(){}}

public extension NodeRepresentable {
    func makeNode() throws -> Node {
        return try makeNode(in: nil)
    }
}

extension Node {
    public init(_ value: Any?, in context: Context = emptyContext) {
        switch value {
        case nil:
            self = .null
            
        case let node as NodeRepresentable:
            self = try! node.makeNode(in: context)
            
        case let array as [NodeRepresentable]:
            self = try! array.makeNode(in: context)
            
        case let dict as [String:NodeRepresentable]:
            self = try! dict.makeNode(in: context)
            
        case let set as SetType:
            self = try! set.makeNode(in: context)
            
        case let value? where context is Collapsed:
            self = [:]
            
            for (key, property) in properties(value) {
                self.merge(node: Node(property.value, in: context), key: key)
            }
            
        case let value?:
            self = [:]
            
            for (key, property) in properties(value) {
                self[key] = Node(property.value, in: context)
                
            }
        }
    }
    
    public mutating func merge(node: Node, key: String) {
        guard let dict = node.object else {
            self[key] = node; return
        }
        
        for (key2, value) in dict {
            self[key + "_" + key2] = value
        }
    }
}

protocol SetType: NodeRepresentable {}

extension Set: SetType {
    public func makeNode(in context: Context = emptyContext) -> Node {
        let array = flatMap {
            try! ($0 as? NodeRepresentable)?.makeNode(in: context)
        }
        
        return Node(array)
    }
}
