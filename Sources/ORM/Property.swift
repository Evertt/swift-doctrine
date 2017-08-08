@_exported import ReflectionExtensions

extension Property {
    var isRelationship: Bool {
        return isBelongsToRelation || isHasManyRelation
    }

    var isBelongsToRelation: Bool {
        return isLazy && type is Entity.Type
    }

    var isHasManyRelation: Bool {
        return isLazy && type is EntityCollection.Type
    }

    var isNodeConvertible: Bool {
        return type is NodeConvertible.Type
    }
}
