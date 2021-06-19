//: [Previous](@previous)

import Foundation

func travel(action: (String, String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", "hell")
    print(description)
    print("I arrived!")
}

// MARK - 매개변수자체 생략 가능
travel { (param: String, esta: String) in
    "I'm going to \($0) \(esta)in my car"
}
//: [Next](@next)
