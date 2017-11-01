import ORM

struct Address: Codable {
    let street: String
    let number: Int
}

extension Address: Equatable {
    static func ==(lhs: Address, rhs: Address) -> Bool {
        return (lhs.street, lhs.number) == (rhs.street, rhs.number)
    }
}

final class User: Entity {
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

final class Post: Entity {
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
    var id: Key<E,ID> {
        return "\(stringValue).id"
    }

    var age: Key<E,Int> {
        return "\(stringValue).age"
    }

    var name: Key<E,String> {
        return "\(stringValue).name"
    }

    var address: Key<E,Address> {
        return "\(stringValue).address"
    }
    
    var posts: RelationKey<User,Post> {
        return "\(stringValue).posts"
    }
}

extension Key where V == Address? {
    var street: Key<E,String> {
        return "\(stringValue).street"
    }
    
    var number: Key<E,Int> {
        return "\(stringValue).number"
    }
}

extension Address {
    static let street : Key<Address,String> = "street"
    static let number : Key<Address,Int>    = "number"
}

extension User {
    static let id      : Key<User,ID>           = "id"
    static let age     : Key<User,Int>          = "age"
    static let name    : Key<User,String>       = "name"
    static let address : Key<User,Address?>     = "address"
    
    static let posts   : RelationKey<User,Post> = "post"
}

extension Post {
    static let id    : Key<Post,ID>     = "id"
    static let title : Key<Post,String> = "title"
    static let user  : Key<Post,User>   = "user"
}
