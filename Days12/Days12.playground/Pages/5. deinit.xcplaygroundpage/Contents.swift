import Foundation

//: deinit
class User {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

//: for문이 끝나면 해당 user상수는 메모리에서 해제
for i in 1...3 {
    let user = User(id: i)
    print("User \(user.id): I'm in control!")
}
