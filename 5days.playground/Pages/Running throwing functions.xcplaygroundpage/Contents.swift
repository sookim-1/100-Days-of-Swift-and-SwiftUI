import UIKit
enum PasswordError: Error {
    case obvious
}


func checkPassword(_ password: String) throws {
    if password == "password" {
        throw PasswordError.obvious
    }
}

do {
    print("start")
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
