@_exported import ReflectionExtensions

extension Property {
    var isRelationship: Bool {
        return isBelongsToRelation || isHasManyRelation
    }

    var isBelongsToRelation: Bool {
        return type is _Entity.Type
    }

    var isHasManyRelation: Bool {
        return type is EntityCollection.Type
    }

    var isNodeConvertible: Bool {
        return type is NodeConvertible.Type
    }
}

extension PropertyType {
    var isRelationship: Bool {
        return isBelongsToRelation || isHasManyRelation
    }
    
    var isBelongsToRelation: Bool {
        return type is _Entity.Type
    }
    
    var isHasManyRelation: Bool {
        return type is EntityCollection.Type
    }
    
    var isNodeConvertible: Bool {
        return type is NodeConvertible.Type
    }
}
