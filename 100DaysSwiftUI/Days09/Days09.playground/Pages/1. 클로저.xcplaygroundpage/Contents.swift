import Foundation

//: 함수를 변수에 할당하기
func greetUser() {
    print("Hi there!")
}

greetUser()

var greetCopy = greetUser
greetCopy()

//: 함수 생성을 건너 뛰고 상수나 변수에 직접 할당하기
var greetCopy1 = {
    print("Hi there!")
}

greetCopy1()

//: 클로저의 매개변수와 반환 사용하기
var greetCopy2 = { (name: String) -> String in
    return "Hi \(name)"
}

greetCopy2("sookim")

//: 함수의 복사본을 만드는 경우 매개변수는 생략됩니다.
func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData
let user = data(1989)
print(user)
