import Foundation

//: 집합의 기본사용방법
let people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])

//: 빈 집합을 생성하는 여러 방법
var people1 = Set<String>()
var people2: Set<String> = []
people1.insert("Denzel Washington")
people1.insert("Tom Cruise")
