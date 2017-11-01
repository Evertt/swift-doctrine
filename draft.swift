let users: [User] = manager
    .where(
        User.name == "Evert" &&
        User.address.street == "Orchideeveld" ||
        User.posts.where(Post.title == "Poep").count > 0
    )
    .order(by: User.age, direction: .ascending)
    .include(User.father, User.posts)
    .get()

for user in users {
    let posts = user.posts
    user.posts.insert(post)
    user.posts.remove(post)
}