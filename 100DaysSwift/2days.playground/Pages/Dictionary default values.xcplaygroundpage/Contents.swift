//: [Previous](@previous)

import Foundation

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]
favoriteIceCream["Paul"]
favoriteIceCream["Charlotte"]

favoriteIceCream["Paul", default: "Unknown"]
favoriteIceCream["Charlotte", default: "Unknown"]
//: [Next](@next)
