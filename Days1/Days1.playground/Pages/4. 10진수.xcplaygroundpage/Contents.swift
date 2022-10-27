import Foundation

//: 부동소수점의 한계
let number = 0.1 + 0.2
print(number)

//: Double -> Int로 변경하는 경우 뒤의 소수점은 모두 제거됩니다.
let double1 = 3.1
let double2 = 3131.3131
let double3 = 3.0
let double4 = 3.7
let int1 = 3
Int(double1)
Int(double2)
Int(double3)
Int(double4)
Int(int1)
