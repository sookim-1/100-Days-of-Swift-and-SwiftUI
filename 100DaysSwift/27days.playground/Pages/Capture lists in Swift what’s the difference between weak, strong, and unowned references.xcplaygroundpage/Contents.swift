//: [Previous](@previous)

import Foundation

class Singer {
    func playSong() {
        print("Shake it off!")
    }
}

// MARK: - Strong capture
func sing() -> () -> Void {
    let taylor = Singer()

    let singing = {
        taylor.playSong()
        return
    }

    return singing
}
// 결과 : Shake it off!

// MARK: - Weak capture optional
//func sing() -> () -> Void {
//    let taylor = Singer()
//
//    let singing = { [weak taylor] in
//        taylor?.playSong()
//        return
//    }
//
//    return singing
//}
// 결과 : nil

// MARK: - Weak capture unwrapping
//func sing() -> () -> Void {
//    let taylor = Singer()
//
//    let singing = { [weak taylor] in
//        taylor!.playSong()
//        return
//    }
//
//    return singing
//}
// 결과 : crash 충돌

// MARK: - Unowned capture
//func sing() -> () -> Void {
//    let taylor = Singer()
//
//    let singing = { [unowned taylor] in
//        taylor.playSong()
//        return
//    }
//
//    return singing
//}
// 결과 : crash 충돌

let singFunction = sing()
singFunction()

class House {
    var ownerDetails: (() -> Void)?

    func printDetails() {
        print("This is a great house.")
    }

    deinit {
        print("I'm being demolished!")
    }
}

class Owner {
    var houseDetails: (() -> Void)?

    func printDetails() {
        print("I own a house.")
    }

    deinit {
        print("I'm dying!")
    }
}

print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = owner.printDetails
    owner.houseDetails = house.printDetails
}

print("Done")

//MARK: - Copies of closures

var numberOfLinesLogged = 0

let logger1 = {
    numberOfLinesLogged += 1
    print("Lines logged: \(numberOfLinesLogged)")
}

logger1()
let logger2 = logger1
logger2()
logger1()
logger2()



//: [Next](@next)
