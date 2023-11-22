import Foundation

//: for문
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {    print("Swift works great on \(os).")
}

//: 중첩반복문
for i in 1...12 {
    print("The \(i) times table:")

    for j in 1...12 {
        print("  \(j) x \(i) is \(j * i)")
    }

    print()     // 개행
}

//: 루프변수 미사용하는 경우 와일드카드 사용
var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric)
