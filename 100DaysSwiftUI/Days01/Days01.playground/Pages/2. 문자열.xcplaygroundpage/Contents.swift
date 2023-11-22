import Foundation

//: 유니코드 문자 사용
let filename = "paris.jpg"
let result = "⭐️ You win! ⭐️"

//: 이스케이핑 문자
let quote = "Then he tapped a sign saying \"Believe\" and walked away."

//: 여러 줄 표현
let movie = """
A day in
the life of an
Apple engineer
"""

//: 문자열 길이 구하기
filename.count

//: 문자열 대문자로 변환
filename.uppercased()

//: 문자열이 선택한 문자로 시작하는지 확인
filename.hasPrefix("p")
filename.hasPrefix("g")

//: 문자열이 선택한 문자로 끝나는지 확인
filename.hasSuffix("p")
filename.hasSuffix("g")
