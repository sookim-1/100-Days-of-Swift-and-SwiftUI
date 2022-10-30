import Foundation

//: 부모클래스
class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
}

//: 자식클래스
class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()
