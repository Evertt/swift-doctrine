import XCTest
import Node
@testable import ORM
import ReflectionExtensions

class Printer: Connection {
    func execute(query: Query) throws -> Data? {
        print("\n", query, "\n")
        
        return nil
    }
    
    init() {}
}

class EntityMapTests: XCTestCase {
    func test_entities_are_correctly_registered_in_the_manager() {
        let manager = Manager(connection: Printer(), entities: [User.self, Post.self])
        
        let address = Address(street: "Orchideeveld", number: 6)
        
        let _: Post? = manager.find(where:
            //Post.title == "First" &&
            //Post.user.address == address &&
            User.posts.filter(Post.title == "Lala").count > 3
        )
        
        let user1 = User(id: 123, name: "Test")
        
        let post = Post(title: "Tla")
        
        user1.posts.append(post)
        
        print("\n", user1.posts.first!.author!.id,"\n")
        
        user1.posts.remove(post)
        
        print("\n", get("author", from: post)!, "\n")
        
        XCTAssert(User.manager === manager)
        XCTAssert(User(name: "").manager === manager)
    }
}
