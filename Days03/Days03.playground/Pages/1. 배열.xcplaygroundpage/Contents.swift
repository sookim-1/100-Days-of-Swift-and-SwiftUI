import Foundation

//: 배열 저장하는 방법
var beatles = ["John", "Paul", "George", "Ringo"]
let numbers = [4, 8, 15, 16, 23, 42]
var temperatures = [25.3, 28.2, 26.4]

beatles[0]
beatles[1]

//: 배열 추가하기
beatles.append("Allen")
beatles.append("Adrian")

//: 빈 배열을 생성하는 여러 방법
var scores = Array<Int>()
var scores2: [Int] = []
var scores3 = [Int]()

//: 배열 여러가지 부가기능
var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)

characters.remove(at: 2)
print(characters.count)

characters.removeAll()
print(characters.count)

let bondMovies = ["Casino Royale", "Spectre", "No Time To Die"]
print(bondMovies.contains("Frozen"))

var cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())
print(cities)

var cities1 = ["London", "Tokyo", "Rome", "Budapest"]
print(cities1.sort())
print(cities1)

let presidents = ["Bush", "Obama", "Trump", "Biden"]
print(presidents.reversed())
print(presidents)
