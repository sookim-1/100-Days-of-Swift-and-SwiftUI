import Foundation

//: 참조타입
class User {
    var username = "Anonymous"
}

var user1 = User()
var user2 = user1
user2.username = "Taylor"
print(user1.username)
print(user2.username)

//: 고유한 복사본을 생성하기
class UniqueUser {
    var username = "Anonymous"

    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

var uniqueUser1 = UniqueUser()
var uniqueUser2 = uniqueUser1.copy()
uniqueUser2.username = "Taylor"
print(uniqueUser1.username)
print(uniqueUser2.username)
