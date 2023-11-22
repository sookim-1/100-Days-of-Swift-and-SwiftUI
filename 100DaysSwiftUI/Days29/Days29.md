
# 1. Word Scramble 프로젝트 설명

-   문자열, 데이터를 테이블형식으로 작동하기 위한 List를 사용합니다.
-   문자열을 사용할 때, Objective-C 프레임워크와의 호환성을 얻기 위해 유니코드표현으로 작업하는 방법을 알아봅니다.

플레이어에게 임의의 8글자 단어를 표시하고 조합하여 새로운 단어를 만드는 프로젝트

----------

# 2. List를 사용하는 방법

SwiftUI의 List는 UIKit의 UITableView와 비슷하게 사용합니다.

List의 작업은 스크롤이 가능한 데이터 테이블을 제공하는 것입니다.

## Form과 List의 차이점

Form과 유사하지만 Form의 목적은 사용자의 입력을 요청하는 것이고 List는 데이터를 표시하는 것을 제외하고 동일합니다.

Form은 동적데이터를 만드는 경우 ForEach를 사용없이는 생성할 수 없지만 List는 가능합니다.

-   listStyle()수정자를 사용하여 모양을 변경할 수 있습니다.
    -   automatic : 자동으로 모양 변경
        
    -   grouped : 그룹별로 분리되고 inset 없는 모양
        
     
    -   inset : inset 없는 모양
        
       
    -   insetGrouped : grouped에서 inset 있는 모양 (form과 유사)
    
        
    -   sidebar : 접었다 펼칠 수 있는 sidebar 제공하는 모양
        
     
        
    -   plain : 기본 모양
        
       
        

----------

List의 데이터는 정적인 행을 사용하거나 동적인 행을 사용할 수 있습니다.

> List 정적, 동적인 행 예시

```swift
// MARK: - List 생성 (정적)
List {
    Text("Hello World")
    Text("Hello World")
    Text("Hello World")
}

// MARK: - ForEach를 활용 (동적)
List {
    ForEach(0..<5) {
        Text("Dynamic row \\($0)")
    }
}

// MARK: - 정적 및 동적 함께 활용
List {
    // Section의 타이틀이 텍스트만 있는 경우 아래처럼
    Section("Section 1") {
        Text("Static row 1")
        Text("Static row 2")
    }

    Section("Section 2") {
        ForEach(0..<5) {
            Text("Dynamic row \\($0)")
        }
    }

    // Section의 타이틀이 여러개인 경우
    Section {
        Text("Static row 3")
        Text("Static row 4")
    } header: {
        Text("Section 3")
        Text("Section 3")
    }
}
```

-   💡 Tip : Section의 헤더를 표시할 때 텍스트뷰 하나만 필요하다면, 바로 사용할 수 있습니다.

> 배열과 함께 List 사용하는 예시

```swift
struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        List(people, id: \\.self) {
            Text($0)
        }
    }
}
```

-   ForEach,List를 사용하는 경우 범위를 하드코딩(0..<5) 하거나 변수데이터에 의존하여 (0..<array.count)를 통해 SwiftUI가 범위 내에 index를 기반으로 각 요소를 고유하게 식별가능했지만, 배열을 사용하는 경우 고유하게 식별하기위해 id 파라미터를 전달합니다.
    -   id
        -   데이터모델의 식별자 키경로
        -   자료형 : id: [KeyPath](https://developer.apple.com/documentation/Swift/KeyPath)<Data.Element, ID> 데이터요소들로부터 ID의 키 경로

----------

# 3. 번들에서 리소스를 로딩하는 방법

-   리소스에는 다양한 파일유형들이 있는데 이미지, color, strings등은 에셋카탈로그에서 로드를 하지만, 텍스트파일, XML, JSON과 같은 특정 파일등은 로드 작업을 동일하게 처리해주어야 합니다.

Xcode가 iOS앱을 빌드할 때 번들(Bundle)을 생성합니다. 모든 애플 플랫폼에서 생성되며, 시스템이 하나의 앱에 필요한 모든 파일을 한 곳에 저장합니다.

여러 번들을 활용하면 더 풍부한 앱을 만들 수 있습니다.

## 번들에서 파일을 찾는 방법

1.  URL은 웹주소를 저장하는 것 뿐만 아니라, 파일위치도 저장할 수 있습니다.
2.  기본 앱 번들에 있는 파일의 URL을 읽으려면 **`Bundle.main.url()` 을 사용합니다. 파일이 존재하면 URL이반환되고 없다면 nil을 반환합니다.**
3.  URL을 통해 **`String(contentsOf:)`** 파일 로드합니다. 로드할 수 없으면 오류가 발생하므로 try, try?를 호출해야 합니다.

> 번들에서 파일을 찾는 예시

```swift
if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
    if let fileContents = try? String(contentsOf: fileURL) {
		    
		}
}

```

----------

# 4. 문자열을 처리하는 방법 (추가)


## 문자열이 제공하는 기능

-   **components(separatedBy:) : 다른 문자열이 발견될 때마다 문자열을 분해하여 단일 문자열을 문자열 배열로 변환할 수 있는 메서드를 제공합니다.**
    
    ```swift
    // 공백을 기준으로 나누는 예시
    let input = "a b c"
    let letters = input.components(separatedBy: " ")
    
    // letters = ["a", "b", "c"]
    
    // 줄바꿈 특수문자 시퀀스 \\n을 기준으로 나누는 예시
    let letters2 = input.components(separatedBy: "\\n")
    ```
    
-   **randomElement() : 배열에서 하나의 항목을 무작위로 반환합니다.**
    
    ```swift
    let letter = letters.randomElement()
    ```
    
-   **trimmingCharacters(in:) : 문자열에서 특정 종류의 문자를 제거합니다.**
    
    ```swift
    let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
    ```
    

----------

# 5. UITextChecker로 단어 철자 확인하는 방법

UITextChecker를 사용하면 철자가 틀린 단어를 확인할 수 있습니다.

-   UITextChecker는 UIKit에서 제공되는 클래스입니다.
-   UITextChecker는 Objective-C언어를 사용하여 작성되어 있습니다.

## 철자 틀린 단어 확인하는 방법

1.  확인할 단어와 UITextChecker 인스턴스를 생성합니다.
    
    ```swift
    let word = "swift"
    let checker = UITextChecker()
    ```
    
2.  확인할 단어의 양을 Checker인스턴스에게 알립니다.
    
    -   범위를 지정해 단어의 부분만 확인할 수 있습니다.
    -   🚨 Checker는 Objective-C언어로 작성되어서 Swift처럼 이모티콘과 같은 복잡한 문자를 저장하지 않기 때문에 Objective-C 문자열 범위를 생성해야 합니다.
    -   UTF-16은 문자열에 문자를 저장하는 방법인 **`문자 인코딩`** 이라고 합니다. Objective-C가 Swift의 문자열이 저장되는 방식을 이해할 수 있도록 여기에서 사용합니다. 둘을 브리징 형식입니다.
    
    ```swift
    let range = NSRange(location: 0, length: word.utf16.count)
    ```
    
3.  단어의 철자가 틀린 위치를 알리도록 요청합니다.
    
    -   Objective-C에는 옵셔널 개념이 없기 때문에 Objective-C에서는 NSNotFound라는 특수 값을 반환합니다.
    
    ```swift
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    let allGood = misspelledRange.location == NSNotFound
    ```
    

----------

# 참고링크

-   UITextChecker 공식문서 - [](https://developer.apple.com/documentation/uikit/uitextchecker)[https://developer.apple.com/documentation/uikit/uitextchecker](https://developer.apple.com/documentation/uikit/uitextchecker)
-   Validating words with UITextChecker - [](https://www.hackingwithswift.com/books/ios-swiftui/validating-words-with-uitextchecker)[https://www.hackingwithswift.com/books/ios-swiftui/validating-words-with-uitextchecker](https://www.hackingwithswift.com/books/ios-swiftui/validating-words-with-uitextchecker)
