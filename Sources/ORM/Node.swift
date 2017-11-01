@_exported import Node
@_exported import NodeExtension

/**
 Please ignore everything in this file.
 This is just me drafting out some random idea.
 Which has almost nothing to do with this library.
*/
 

protocol ReducableToUsers: Codable {
    var allUsers: Set<User> { get }
}

final class User: Entity, ReducableToUsers {
    let id: ID
    let name: String

    var groups: Set<Group> {
        didSet {
            for group in oldValue.subtracting(groups) {
                group.users.remove(self)
            }
            
            for group in groups.subtracting(oldValue) {
                group.users.insert(self)
            }
        }
    }
    
    init(id: ID = ID(), name: String, groups: Set<Group> = []) {
        self.id        = id
        self.name      = name
        self.groups    = groups
    }
    
    var allUsers: Set<User> {
        return [self]
    }
}

final class Group: Entity {
    let id: ID
    let name: String
    
    var parent: Group? {
        didSet {
            oldValue?.children.remove(self)
            parent?.children.insert(self)
        }
    }
    
    var children: Set<Group> {
        didSet {
            for child in oldValue.subtracting(children) where child.parent == self {
                child.parent = nil
            }
            
            for child in children.subtracting(oldValue) where child.parent != self {
                child.parent = self
            }
        }
    }
    
    var users: Set<User> = [] {
        didSet {
            for user in oldValue.subtracting(users) {
                user.groups.remove(self)
            }
            
            for user in users.subtracting(oldValue) {
                user.groups.insert(self)
            }
        }
    }
    
    var allUsers: Set<User> {
        return children
            .reduce(Set<User>(), {$0.union($1.allUsers)})
            .union(users)
    }
    
    init(id: ID = ID(), name: String, parent: Group? = nil, children: Set<Group> = []) {
        self.id        = id
        self.name      = name
        self.parent    = parent
        self.children  = children
    }
}

final class Post {
    
}

final class Ability<E: Entity>: Entity {
    let id: ID
    let action: Action
    let entity: E
    
    init(id: ID = ID(), action: Action, entity: E) {
        self.id     = id
        self.action = action
        self.entity = entity
    }
}

final class Permission<E: Entity, UC: ReducableToUsers>: Entity {
    let id: ID
    let ability: Ability<E>
    let granted: Bool
    let users: UC
    
    init(id: ID = ID(), users: UC, ability: Ability<E>, granted: Bool) {
        self.id = id
        self.users = users
        self.ability = ability
        self.granted = granted
    }
}

enum Action: String, Codable {
    case browse, read, edit, add, delete
}

extension User {
    static let id = Key<User, ID>("id")
}

extension Group {
    static let id = Key<Group, ID>("id")
}

extension Permission {
    static var id: Key<Permission<E, UC>, ID> {
        return Key<Permission<E, UC>, ID>("id")
    }
}

extension Ability {
    static var id: Key<Ability<E>, ID> {
        return Key<Ability<E>, ID>("id")
    }
}
