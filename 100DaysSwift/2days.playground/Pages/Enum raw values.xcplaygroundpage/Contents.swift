//: [Previous](@previous)

import Foundation

enum Planet: Int {
    case mercury
    case venus 
    case earth = 4
    case mars
}

let a = Planet(rawValue: 0)
let b = Planet(rawValue: 1)
let c = Planet(rawValue: 2)
let d = Planet(rawValue: 3)
let e = Planet(rawValue: 4)
let f = Planet(rawValue: 5)

Planet.earth.rawValue

//: [Next](@next)
