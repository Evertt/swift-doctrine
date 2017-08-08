import Foundation

public struct TableColumn {
    let table  : String?
    let column : String
    
    public init(table: String? = nil, column: String) {
        self.table  = table
        self.column = column
    }
    
    public init(_ field: String) {
        var components = field.components(separatedBy: ".")
        
        table = components.count > 1 ? components.removeFirst() : nil

        column = components.joined(separator: ".")
    }
}

extension TableColumn: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = TableColumn(value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self = TableColumn(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self = TableColumn(value)
    }
}

extension TableColumn: CustomStringConvertible {
    public var description: String {
        return "`" + [table, column]
            .flatMap{$0}
            .joined(separator: "`.`") + "`"
    }
}
