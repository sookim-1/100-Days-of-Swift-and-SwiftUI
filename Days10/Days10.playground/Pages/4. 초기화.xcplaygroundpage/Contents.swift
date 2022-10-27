import Foundation

//: 기본 이니셜라이저
struct Player {
    let name: String
    let number: Int
}

let player = Player(name: "Megan R", number: 15)
print(player)

//: 커스텀 이니셜라이저
struct RandomPlayer {
    let name: String
    let number: Int 
    
    init(name: String) {
        self.name = name
        number = Int.random(in: 1...20)
    }
}

let randomPlayer = RandomPlayer(name: "faker")
print(randomPlayer)

//: 기본값 제공한 경우 이니셜라이저에서 프로퍼티 생략이 가능합니다.
struct DefaultPlayer {
    let name: String
    let number: Int = 5
    
    init(name: String) {
        self.name = name
    }
}

let defaultPlayer = DefaultPlayer(name: "faker")
print(defaultPlayer)
