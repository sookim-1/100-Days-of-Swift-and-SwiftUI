import Foundation

//: 딕셔너리 반환하기
func getUserDict() -> [String: String] {
    [
        "firstName": "Taylor",
        "lastName": "Swift"
    ]
}

let userDict = getUserDict()
print("Name: \(userDict["firstName", default: "Anonymous"]) \(userDict["lastName", default: "Anonymous"])")

//: 튜플 반환하기
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let (firstName, lastName) = getUser()
print("Name: \(firstName) \(lastName)")
