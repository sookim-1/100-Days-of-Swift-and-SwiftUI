
# 1. 텍스트필드로 텍스트를 입력받는 방법

텍스트필드는 텍스트를 입력받는데 텍스트를 숫자로 변환하여 사용할 수 있습니다.

-   텍스트의 서식을 지정(format)을 통해 변환할 수 있습니다.
-   keyboardType() : 텍스트필드의 키보드 종류를 지정할 수 있습니다.
    -   숫자로 지정한 경우 텍스트필드의 복사붙여넣기를 통해 입력할 수 있지만, return키를 누르면 텍스트필드가 자동으로 잘못된 값을 필터링합니다.

> 요금을 입력받는 예시

```swift
TextField("요금", value: $checkAmout, format: .currency(code: Locale.current.currencyCode ?? "USD"))
					.keyboardType(.decimalPad)

```

-   Locale은 iOS에서 사용자의 지역 설정을 저장하고 있는 구조체입니다.
-   프로퍼티의 값이 변경되면 body를 다시 로드하여 업데이트된 값을 표시하여 뷰를 반환합니다.

----------

# 2. Picker를 만드는 방법

Picker는 다양한 용도로 사용되며 사용중인 장치와 사용되는 환경에 따라 다르게 보일 수 있습니다.

-   pickerStyle() : 옵션을 보여주는 방법을 설정할 수 있습니다.
    -   옵션의 수가 적은 경우 segmented를 활용할 수 있습니다

> 인원수를 입력받는 예시

```swift
Picker("인원 수", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\\($0) 명")
                        }
                    }

```

-   numberOfPeople의 값을 2로 주어도 범위는 0부터 시작하므로 0번째 행에 2가 추가된 상태로 시작해서 4명으로 표시됩니다.

----------

> 퍼센트를 입력받는 예시

```swift
Picker("Tip percentage", selection: $tipPercentage) {
        ForEach(tipPercentages, id: \\.self) {
            Text($0, format: .percent)
        }
    }
		.pickerStyle(.segmented)

```

-   Text의 format형식을 percent로 변환할 수 있습니다.

----------

# 3. Section 헤더를 설정하는 방법

Section을 사용할 때 헤더를 통해 Section에 대해 설명할 수 있습니다.

-   첫번째 클로저에 섹션본문을 지정하고 두번째 클로저에 헤더를 지정합니다.

> 헤더를 사용한 예시

```swift
Section {
    Text("Content")
} header: {
    Text("Header")
}

```

# 4. 키보드를 제거하는 방법

키보드를 입력하기 위해 키보드가 나타나면, 키보드의 return키를 입력하지 않으면 닫히지 않습니다.

위의 문제는 키보드의 포커스의 여부를 결정하도록 설정하면 해결할 수 있습니다.

> 키보드를 제거하는 예시

```swift
@FocusState private var isFocused: Bool

TextField("요금", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
.toolbar {
    ToolbarItemGroup(placement: .keyboard) {    
				Spacer()       
        
				Button("Done") {
            amountIsFocused = false
        }
    }
}


```

-   @FocusState 프로퍼티를 통해 포커스가 되어있으면 true이고 되어있지 않으면 false가 되도록 합니다.
-   텍스트필드에 이 프로퍼티를 추가합니다.
-   toolbar() 수정자를 사용하면 툴바 항목을 지정할 수 있습니다.
-   ToolbarItemGroup을 통해 툴바아이템을 제공할 수 있습니다. placement를 통해 키보드툴바에 추가합니다.
-   Spacer()를 통해 유동적인 빈 공간을 배치하여 가운데에서 오른쪽으로 버튼을 이동시킵니다. → 현재는 빈공간이 먼저왔기 때문에 오른쪽으로 이동하는 것입니다.
