import Foundation

//: didSet을 사용하여 값이 변경될 때마다 출력하기
struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3

//: newValue, oldValue
struct App {
    var contacts = [String]() {
        willSet {
            print("<willSet> property: \(contacts)")
            print("<willSet> New value: \(newValue)")
        }

        didSet {
            print("<didSet> property: \(contacts)")
            print("<didSet> Old value:  \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Xcode")
