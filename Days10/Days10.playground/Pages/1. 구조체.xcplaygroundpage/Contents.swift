import Foundation

//: 구조체 사용하기
struct Album {
    let title: String
    let artist: String
    let year: Int

    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

//: mutating 키워드
struct Employee {
    let name: String
    var vacationRemaining: Int

    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

let letEmployee = Employee(name: "first", vacationRemaining: 1)
var varEmployee = Employee(name: "second", vacationRemaining: 1)
// 에러 : letEmployee.takeVacation(days: 5)
varEmployee.takeVacation(days: 5)
