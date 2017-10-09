public struct Query<E: Entity> {
    public var action: Action
    public var filter: Filter<E> = .all([])
    public var sortBy: [Sort] = []
    public var limit : Limit?
    public var data  : Node?
    
    public init(action: Action) {
        self.action = action
    }
    
    public func filter(_ filter: Filter<E>) -> Query<E> {
        var new = self
        new.filter = new.filter.and(filter)
        return new
    }
    
    public func order<T: Comparable>(by key: Key<E,T>, direction: Sort.Direction = .ascending) -> Query<E> {
        var new = self
        new.sortBy.append(Sort(field: TableColumn(key.stringValue), direction: direction))
        return new
    }
    
    public func limit(_ count: Int, offset: Int = 0) -> Query<E> {
        var new = self
        new.limit = Limit(count: count, offset: offset)
        return new
    }
    
    public func update<C: SomeCodingKey>(_ data: [C:Encodable]) {
        
    }
}
