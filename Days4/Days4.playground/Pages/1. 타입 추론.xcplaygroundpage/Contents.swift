import Foundation

//: 타입 추론
let surname = "Lasso"
var score = 0

//: 타입 명시
let surname1: String = "Lasso"
var score1: Int = 0
var albums: [String] = ["Red", "Fearless"]
var user: [String: String] = ["id": "@twostraws"]
var books: Set<String> = Set(["The Bluest Eye", "Foundation", "Girl, Woman, Other"])

//: 상수 설정
let username: String
username = "@twostraws"
print(username)

var username1: String
username1 = "@twostraws"
print(username1)
