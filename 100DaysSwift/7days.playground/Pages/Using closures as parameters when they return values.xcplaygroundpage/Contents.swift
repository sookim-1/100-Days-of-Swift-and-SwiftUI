//: [Previous](@previous)

import Foundation

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

var result: String = ""

travel { (place: String) -> String in
    result = "\(place)도착"
    return "\(place)도착"
}

print(result)

func manipulate(numbers: [Int], using algorithm: (Int) -> Int) {
    for number in numbers {
        let result = algorithm(number)
        print("Manipulating \(number) produced \(result)")
    }
}
manipulate(numbers: [1, 2, 3]) { number in
    return number * number
}

func bakeCookies(number: Int, secretIngredient: () -> String) {
    for _ in 0..<number {
        print("Adding butter...")
        print("Adding flour...")
        print("Adding sugar...")
        print("Adding egg...")
        let extra = secretIngredient()
        print(extra)
    }
}
bakeCookies(number: 1) {
    return "Adding vanilla extract"
}
//: [Next](@next)
