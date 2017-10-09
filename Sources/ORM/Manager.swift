import Foundation

public protocol Connection {
    func execute<E>(query: Query<E>) throws -> Data?
}

//public extension Query {
//    static func fetch() -> Query<E> {
//
//    }
//}

public class Manager {
    static var instances = [EntityHash:Manager]()
    
    let connection: Connection
    var originals = [EntityHash:[ID:Node]]()
    var maps = [EntityHash:EntityMap]()
    
    public init(connection: Connection, entities: [_Entity.Type]) {
        self.connection = connection
        Manager.instances += entities.map { ($0.hash, self) }
    }
    
    public func find<E>(where filter: Filter<E>) -> [E] {
        return fetch(E.self, filter).map { decode($0) } ?? []
    }
    
    public func find<E>(where filter: Filter<E>) -> E? {
        return fetch(E.self, filter).map { decode($0) }
    }
    
    public func find<E: Entity>(id: ID) -> E? {
        return fetch(E.self, E.id == id).map { decode($0) }
    }
    
    private func fetch<E>(_ type: E.Type, _ filter: Filter<E>) -> Data? {
        var query = Query<E>(action: .fetch)
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
