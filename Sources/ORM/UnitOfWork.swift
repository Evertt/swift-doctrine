import Foundation
import Node

//public class NodeEncoder: Encoder {
//    /// The path of coding keys taken to get to this point in encoding.
//    /// A `nil` value indicates an unkeyed container.
//    public let codingPath: [CodingKey]
//    
//    /// Any contextual information set by the user for encoding.
//    public let userInfo: [CodingUserInfoKey : Any]
//    
//    public init() {
//        codingPath = []
//        userInfo = [:]
//    }
//    
//    /// Returns an encoding container appropriate for holding multiple values keyed by the given key type.
//    ///
//    /// - parameter type: The key type to use for the container.
//    /// - returns: A new keyed encoding container.
//    /// - precondition: May not be called after a prior `self.unkeyedContainer()` call.
//    /// - precondition: May not be called after a value has been encoded through a previous `self.singleValueContainer()` call.
//    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
//        fatalError()
//    }
//    
//    /// Returns an encoding container appropriate for holding multiple unkeyed values.
//    ///
//    /// - returns: A new empty unkeyed container.
//    /// - precondition: May not be called after a prior `self.container(keyedBy:)` call.
//    /// - precondition: May not be called after a value has been encoded through a previous `self.singleValueContainer()` call.
//    public func unkeyedContainer() -> UnkeyedEncodingContainer {
//        fatalError()
//    }
//    
//    /// Returns an encoding container appropriate for holding a single primitive value.
//    ///
//    /// - returns: A new empty single value container.
//    /// - precondition: May not be called after a prior `self.container(keyedBy:)` call.
//    /// - precondition: May not be called after a prior `self.unkeyedContainer()` call.
//    /// - precondition: May not be called after a value has been encoded through a previous `self.singleValueContainer()` call.
//    public func singleValueContainer() -> SingleValueEncodingContainer {
//        fatalError()
//    }
//}
//
//struct NodePrimitiveContainer: UnkeyedEncodingContainer {
//    var value: Node
//    
//    var codingPath: [CodingKey]
//    
//    var count: Int
//    
//    mutating func encodeNil() throws {
//        value = nil
//    }
//    
//    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
//        
//    }
//    
//    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
//        <#code#>
//    }
//    
//    mutating func superEncoder() -> Encoder {
//        <#code#>
//    }
//}

