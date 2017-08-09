public class Manager {
    public typealias EntityFactory = () -> Entity
    
    static var instances = [EntityHash:Manager]()
    
    let factories: [EntityHash:EntityFactory]
    
    var originals = [EntityHash:[ID:Node]]()
    
    public init(entityFactories: EntityFactory...) {
        factories = entityFactories.map { ($0().hash, $0) }
        Manager.instances += factories.map { ($0.key, self) }
    }
    
    public func find<E: Entity>(where filter: Filter) -> [E] {
        return []
    }
    
    public func find<E: Entity>(where filter: Filter) -> E? {
        return nil
    }
    
    public func find<E: Entity>(id: ID) -> E? {
        return nil
    }
}
