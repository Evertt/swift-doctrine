struct Key: Hashable {
    let id: ID
    let type: String
    
    var hashValue: Int {
        return type.hashValue &+ id.hashValue
    }
    
    static func ==(left: Key, right: Key) -> Bool {
        return left.type == right.type && left.id == right.id
    }
    
    init(for entity: Entity) {
        id   = entity.id
        type = entity.type
    }
    
    init(entityType: Entity.Type, id: ID) {
        self.id   = id
        self.type = entityType.type
    }
}
