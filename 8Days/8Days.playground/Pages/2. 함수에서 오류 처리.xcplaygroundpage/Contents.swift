import Foundation

//: 1. 발생할 수 있는 오류 명시하기
enum PasswordError: Error {
    case short, obvious
}

//: 2. 오류가 발생하면 처리할 함수를 작성하기
func checkPassword(_ password: String) throws -> String {
    // 5자 미만인 경우 오류발생
    if password.count < 5 {
        throw PasswordError.short
    }
    
    // 12345인 경우
    if password == "12345" {
        throw PasswordError.obvious
    }
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

//: 3. 발생할 수 있는  오류 처리하기
let string = "12345"

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch {
    print("There was an error.")
}

//: 추가
let stringAdd = "123456"

do {
    let result = try checkPassword(stringAdd)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}
