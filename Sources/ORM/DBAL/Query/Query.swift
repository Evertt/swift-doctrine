public struct Query {
    public var table : String
    public var action: Action
    public var filter: Filter?
    public var sortBy: [Sort] = []
    public var limit : Limit?
    public var data  : Node?
    
    public init(table: String, action: Action) {
        self.table  = table
        self.action = action
    }
}
