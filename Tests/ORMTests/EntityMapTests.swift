import XCTest
import Node
@testable import ORM

class EntityMapTests: XCTestCase {
    func test_entities_are_correctly_registered_in_the_manager() {
        let manager = Manager(entityFactories:
            {User(id: 0, name: "")}
        )
        
        XCTAssert(User.manager === manager)
        XCTAssert(User(name: "").manager === manager)
    }

    func test_entities_are_correctly_mapped_to_node_for_the_database() {
        let _ = Manager(entityFactories:
            { User(id: 0, name: "") },
            { Post(id: 0, title: "") }
        )
        
        let user = User(name: "Evert")
        
        let post1 = Post(title: "Een")
        let post2 = Post(title: "Twee")
        
        var blacklist: Set<Key> = []
        
        user.posts += [post1, post2]
        
        let node = user.makeNodeForDB(dontAdd: &blacklist)
        
        XCTAssertNotNil(node.object)
        
        print("\n", node, "\n")
    }
    
    func test_entities_can_be_initialized_from_the_database() {
        let _ = Manager(entityFactories:
            { Post(id: 0, title: "") }
        )
        
        let post1 = Post.initFromDB(row: [
            "id": 2, "title": "Hallo!!!"
        ])
        
        let post2 = Post.initFromDB(row: [
            "id": 3, "title": "Doei!!!"
        ])
        
        XCTAssert(post1.id == 2)
        XCTAssert(post1.title == "Hallo!!!")
        
        XCTAssert(post2.id == 3)
        XCTAssert(post2.title == "Doei!!!")
    }
}
