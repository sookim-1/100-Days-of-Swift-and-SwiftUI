//: [Previous](@previous)

import Foundation

let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}

driving("London")

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

print(drivingWithReturn("Seoul"))

// MARK - 하나의 매개 변수를 받아들이고 아무것도 반환하지 않는 클로저
let payment = { (user: String) in
    print("Paying \(user)…")
}

// MARK - 하나의 매개 변수를 받아들이고 Bool 반환하는 클로저
let payment1 = { (user: String) -> Bool in
    print("Paying \(user)…")
    return true
}

// MARK - 매개 변수를 받아들이지 않고 값을 반환
let payment3 = { () -> Bool in
    print("Paying an anonymous person…")
    return true
}

func payment4() -> Bool {
    print("Paying an anonymous person…")
    return true
}



//: [Next](@next)
