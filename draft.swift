let users: [User] = manager
    .where(
        \.name == "Evert" &&
        \.address.street == "Orchideeveld" ||
        \.posts.where(\.title == "Poep").count > 0
    )
    .order(by: \.age, direction: .ascending)
    .include(\.father, \.posts)
    .get()

for user in users {
    let posts = user.posts
    user.posts.insert(post)
    user.posts.remove(post)
}