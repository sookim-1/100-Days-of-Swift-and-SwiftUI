//: [Previous](@previous)

import Foundation

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }

struct a: Employee {
    func calculateWages() -> Int {
        <#code#>
    }
    
    func study() {
        <#code#>
    }
    
    func takeVacation(days: Int) {
        <#code#>
    }
    
    
}
//: [Next](@next)
