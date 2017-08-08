@_exported import Node
@_exported import NodeExtension

extension Node {
    init(_ value: Any?, dontAdd blacklist: inout Set<ORM.Key>) {
        if let entity = value as? Entity {
            self = entity.makeNodeForDB(dontAdd: &blacklist)
        }
        
        else if let collection = value as? EntityCollection {
            self = Node(collection.map { $0.makeNodeForDB(dontAdd: &blacklist) })
        }
        
        else { self = .null }
    }
}
