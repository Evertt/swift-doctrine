import Foundation

public protocol Connection {
    func execute(query: Query) throws -> Data?
}

public class Manager {
    static var instances = [EntityHash:Manager]()
    
    let connection: Connection
    var originals = [EntityHash:[ID:Node]]()
    var maps = [EntityHash:EntityMap]()
    
    public init(connection: Connection, entities: [_Entity.Type]) {
        self.connection = connection
        Manager.instances += entities.map { ($0.hash, self) }
    }
    
    public func find<E: Entity>(where filter: Filter) -> [E] {
        return fetch(E.self, filter).map { decode($0) } ?? []
    }
    
    public func find<E: Entity>(where filter: Filter) -> E? {
        return fetch(E.self, filter).map { decode($0) }
    }
    
    public func find<E: Entity>(id: ID) -> E? {
        return fetch(E.self, E.id == id).map { decode($0) }
    }
    
    private func fetch<E: Entity>(_ type: E.Type, _ filter: Filter) -> Data? {
        var query = Query(table: E.type, action: .fetch)
        query.filter = filter
        
        return try! connection.execute(query: query)
    }
    
    private func decode<E: Entity>(_ data: Data) -> E {
        return try! JSONDecoder().decode(E.self, from: data)
    }
    
    private func decode<E: Entity>(_ data: Data) -> [E] {
        return try! JSONDecoder().decode([E].self, from: data)
    }
}
