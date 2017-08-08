extension Query {
    public struct Sort: CustomStringConvertible {
        public enum Direction: String {
            case ascending = "ASC", descending = "DESC"
        }
        
        public let field       : TableColumn
        public let direction   : Direction
        public let description : String
        
        public init(field: TableColumn, direction: Direction) {
            self.field       = field
            self.direction   = direction
            self.description = "\(field) \(direction.rawValue)"
        }
    }
}
