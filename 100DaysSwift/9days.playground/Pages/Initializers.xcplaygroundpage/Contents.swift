//: [Previous](@previous)

import Foundation

struct User {
    var username: String

    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
print(user.username)
user.username = "twostraws"
print(user.username)

struct Book {
    var title: String = "title"
    var author: String = "author"
    init(bookTitle: String) {
        title = bookTitle
    }
}
let book = Book(bookTitle: "Beowulf")
book.title
book.author
//: [Next](@next)
