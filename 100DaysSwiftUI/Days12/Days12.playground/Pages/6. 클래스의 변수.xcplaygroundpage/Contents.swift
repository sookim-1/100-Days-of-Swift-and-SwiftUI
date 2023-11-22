import Foundation

//: 클래스의 변수
class User {
    var name = "Paul"
}

var user = User()
user.name = "Taylor"

//: user에 새로운 클래스인스턴스를 덮어쓰고 다시 재설정
user = User()
print(user.name)
