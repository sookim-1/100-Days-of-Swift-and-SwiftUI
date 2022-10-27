import Foundation

//: 딕셔너리 키 값 찾는 법
let employee2 = [
    "name": "Taylor Swift",
    "job": "Singer",
    "location": "Nashville"
]

print(employee2["name"])
print(employee2["job"])
print(employee2["location"])
print(employee2["name", default: "Unknown"])
print(employee2["job", default: "Unknown"])
print(employee2["location", default: "Unknown"])

//: 빈 딕셔너리 초기화방법
var heights = [String: Int]()
var heights1: [String: Int] = [:]

//: 딕셔너리의 유용한 기능
heights.count
heights.removeAll()

