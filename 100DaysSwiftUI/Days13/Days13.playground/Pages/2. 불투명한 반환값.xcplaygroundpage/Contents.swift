import Foundation

//: 불투명한 반환값
func getRandomNumber() -> some Equatable {
    return Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    return Bool.random()
}

print(getRandomNumber() == getRandomNumber())
print(getRandomBool() == getRandomBool())
