반복문(Loop)은 **특정 작업을 반복적으로 수행하는 프로그래밍 문법입니다.**

# 1. for 반복문을 사용하는 방법

스위프트에서 반복문을 사용하는 방법은 for문을 사용할 수 있습니다.

기본적인 형태는 `for` 키워드 뒤에 반복작업 중의 상수명 작성한 후 `in` 키워드 뒤에 반복할 모든항목을 작성합니다.

for문은 범위나 데이터의 양이 한정되어있는 경우 사용하면 유용합니다.

---
> for문 예시

```swift
let foodList = ["Cake", "Pizza", "CreamSource"]

for food in foodList {
	print(food)
}

// Cake
// Pizza
// CreamSource

```

-   루프 변수의 특징
    -   사용하지 않는 경우, 와일드카드 `_` 로 사용할 수 있습니다.
    -   루프괄호안에서만 사용할 수 있습니다.
    -   값을 변경할 수 없습니다.
    -   하나의 사이클이 끝난 후 다음 값으로 변경됩니다.

# 2. while 반복문을 사용하는 방법

스위프트에서 반복문을 사용하는 또 다른 방법인 while문을 사용할 수 있습니다.

while문을 사용하는 방법은 `while` 키워드를 입력 한 후 뒤에 조건을 작성합니다. 작성하면 조건이 거짓일 때까지 `{}` 안의 코드가 실행됩니다.

while문은 어떤 조건이 필요할 때 유용합니다.


# 3. 반복문에서 break, continue 키워드 사용하는 방법

반복문을 사용할 때 사이클을 건너뛰는 방법을 사용할 때 `break`, `continue` 키워드를 사용할 수 있습니다.

-   `break` : 해당 사이클을 종료하고 모든 사이클을 건너 뛸 때 사용합니다.
-   `continue` : 현재 사이클을 건너 뛸 때 사용합니다.

---

> break 예시

-   2와 4의 배수를 4개만 추출한 후 반복문을 종료합니다.

```swift
let number2 = 2
let number4 = 4
var multiples: [Int] = []

for i in 1...100 {
    if i.isMultiple(of: number2) && i.isMultiple(of: number4) {
        multiples.append(i)

        if multiples.count == 4 {
            break
        }
    }
}

print(multiples)

// [4, 8, 12, 16]

```
---
> continue 예시

```swift
let numList = [1, 2, 3]

for num in numList {
    continue
    print(num)
}

// 아무것도 출력되지 않습니다.

let numList = [1, 2, 3]

for num in anumList{
    print(num)
    continue
}

// 1
// 2
// 3

```
