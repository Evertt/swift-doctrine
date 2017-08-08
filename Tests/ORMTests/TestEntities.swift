import ORM

struct Address {
    let street: String
    let number: Int
}

class User: Entity {
    let id: ID
    var name: String
    var address: Address? = nil
    
    lazy var posts: HasMany<Post> = self.hasMany(Post.self)
    
    init(id: ID = ID(), name: String, posts: [Post] = []) {
        self.id     = id
        self.name   = name
        self.posts += posts
    }
}

class Post: Entity {
    let id: ID
    var title: String
    
    lazy var user: User = self.belongsTo(User.self)
    
    init(id: ID = ID(), title: String, user: User? = nil) {
        self.id    = id
        self.title = title
        
        if let user = user {
            self.user = user
        }
    }
}
