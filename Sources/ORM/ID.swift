import struct ID.IID

extension IID: NodeConvertible {
    public func makeNode(in context: Context? = nil) -> Node {
        return Node(hashValue)
    }
    
    public init(node: Node) throws {
        guard let int = node.int else {
            fatalError("\(#file) -> \(#function) at line \(#line)")
        }
        
        self = IID(int)
    }
}

public typealias ID = IID
