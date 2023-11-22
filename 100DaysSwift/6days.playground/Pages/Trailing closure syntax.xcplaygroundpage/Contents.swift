import UIKit

// MARK - 클로저가 매개변수 마지막인경우
func travel(name: String, action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
    print("My \(name)")
}

travel(name: "Taylor") {
    print("I'm driving in my car")
}

travel(name: "Taylor", action: {
    print("I'm driving in my car")
})

// MARK - 클로저가 매개변수 마지막이 아닌 경우

func travel(action: () -> Void, name: String) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
    print("My \(name)")
}

travel(action: {
    print("I'm driving in my car")
}, name: "Taylor")

func goCamping(then action: () -> Void) {
    print("We're going camping!")
    action()
}
goCamping {
    print("Sing songs")
    print("Put up tent")
    print("Attempt to sleep")
}

goCamping(then: {
    print("Sing songs")
    print("Put up tent")
    print("Attempt to sleep")
})
