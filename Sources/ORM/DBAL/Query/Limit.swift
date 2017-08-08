extension Query {
    public struct Limit: CustomStringConvertible {
        public let count       : Int
        public let offset      : Int
        public let description : String
        
        public init(count: Int, offset: Int) {
            self.count       = count
            self.offset      = offset
            self.description = "LIMIT \(count) OFFSET \(offset)"
        }
    }
}
