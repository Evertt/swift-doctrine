import XCTest
import Node
@testable import ORM
import ReflectionExtensions

class Printer: Connection {
    func execute<E>(query: Query<E>) throws -> Data? {
        print("\n", query, "\n")
        
        return nil
    }
    
    init() {}
}

class EntityMapTests: XCTestCase {
    func test_entities_are_correctly_registered_in_the_manager() {
        let manager = Manager(connection: Printer(), entities: [User.self, Post.self])
        
        let address: Address = Address(street: "Orchideeveld", number: 6)
        
        let q = Query<User>(action: .fetch)
            .filter(.name == "First"
                 && .age >= 18
                 || .address != address
                 || Key<User,Address?>.address.number == 6
//                 || Key<User,Int>.posts.filter(.title == "Lala").count > 3
            )
            .order(by: .age)
        
        print("\n", q.filter, "\n")
        
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
