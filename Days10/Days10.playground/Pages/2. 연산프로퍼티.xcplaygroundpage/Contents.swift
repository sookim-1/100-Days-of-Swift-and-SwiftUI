import Foundation

//: 연산 프로퍼티
struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int {
        vacationAllocated - vacationTaken
    }
}

var archer = Employee(name: "Sterling Archer", vacationAllocated: 14)
archer.vacationTaken += 4
print(archer.vacationRemaining)
archer.vacationTaken += 4
print(archer.vacationRemaining)


//: getter, setter
struct EmployeeSetter {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }

        set {
            print(newValue)
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var archerSetter = EmployeeSetter(name: "Sterling Archer", vacationAllocated: 14)
archerSetter.vacationTaken += 4
print(archerSetter.vacationRemaining)
archerSetter.vacationRemaining = 5
print(archerSetter.vacationAllocated)


struct Student {
    let name: String
    var age: Int
    
    var futureAge: Int {
        get {
            return age + 10
        }
    
        set {
            print("10년이 지났다.")
            age = newValue
        }
    }
}

var chulsu = Student(name: "chulsu", age: 10)

print("철수의 현재나이 : \(chulsu.age)")
chulsu.futureAge = 20
print("철수의 현재나이 : \(chulsu.age)")

