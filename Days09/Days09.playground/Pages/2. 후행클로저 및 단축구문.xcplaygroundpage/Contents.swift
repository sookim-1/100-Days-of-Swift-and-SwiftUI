import Foundation

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]

//: 후행클로저 사용 전
let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})

print(captainFirstTeam)

//: 후행클로저 사용 후
let captainFirstTeam1 = team.sorted { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}
print(captainFirstTeam1)

//: 단축구문
let captainFirstTeam2 = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }

    return $0 < $1
}
print(captainFirstTeam2)

