import ORM

struct Address: Codable {
    let street: String
    let number: Int
}

extension Address: Equatable {
    static func ==(lhs: Address, rhs: Address) -> Bool {
        return lhs.street == rhs.street && lhs.number == rhs.number
    }
}

class User: Entity {
    let id      : ID
    var name    : String
    var age     : Int = 0
    var address : Address?
    
    lazy var posts = self.hasMany(Post.self, reversedBy: "author")
    
    init(id: ID = ID(), name: String, address: Address? = nil) {
        self.id      = id
        self.name    = name
        self.address = address
    }
}

class Post: Entity {
    let id     : ID
    var title  : String
    
    lazy var author: User? = self.belongsTo(User.self)
    
    init(id: ID = ID(), title: String, author: User? = nil) {
        self.id     = id
        self.title  = title
        
        if let author = author {
            self.author = author
        }
    }
}

extension Key where V == User {
    var id: Key<ID> {
        return Key<ID>("\(stringValue).id")
    }

    var age: Key<Int> {
        return Key<Int>("\(stringValue).age")
    }

    var name: Key<String> {
        return Key<String>("\(stringValue).name")
    }

    var address: Key<Address> {
        return Key<Address>("\(stringValue).address")
    }
    
    var posts: Key<HasMany<User,Post>> {
        return Key<HasMany<User,Post>>("\(stringValue).posts")
    }
}

extension Key where V == Address {
    var street: Key<String> {
        return Key<String>("\(stringValue).street")
    }
    
    var number: Key<Int> {
        return Key<Int>("\(stringValue).number")
    }
}

extension Address {
    static let street = Key<String>("street")
    static let number = Key<Int>("number")
}

extension User {
    static let id      = Key<ID>("id")
    static let age     = Key<Int>("age")
    static let name    = Key<String>("name")
    static let address = Key<Address>("address")
    static let posts   = RelationKey<HasMany<User,Post>>("posts")
}

extension Post {
    static let id    = Key<ID>("id")
    static let title = Key<String>("title")
    static let user  = Key<User>("user")
}
