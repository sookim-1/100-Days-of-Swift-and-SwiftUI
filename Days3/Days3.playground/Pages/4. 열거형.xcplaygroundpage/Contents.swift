import Foundation

//: 열거형을 사용하는 방법
enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday

var day1 = Weekday.monday
day1 = .tuesday
day1 = .friday
