//: [Previous](@previous)

import Foundation

enum PasswordError: Error {
    case obvious
}


func checkPassword(_ password: String) throws {
    if password == "password" {
        throw PasswordError.obvious
    }
}


//: [Next](@next)
