
# 1. iExpense프로젝트 설명

개인 비용과 사업 비용을 구분하여 비용을 추적하는 프로젝트를 만듭니다.

-   다른 화면을 표시 및 제거합니다.
-   List에서 행을 제거합니다.
-   사용자 데이터를 저장하고 로드합니다.

----------

# 2. @State가 구조체에서만 동작하는 이유

@State 프로퍼티래퍼는 현재 뷰에 로컬 데이터용으로 설계되어서 뷰 간에 데이터를 공유하려는 경우 유용하지 않습니다.

> 왜 유용하지 않은지에 대한 예시

```swift
/// 사용자 정보를 저장하는 구조체
struct User {
    var firstName = "Soo"
    var lastName = "Kim"
}

struct ContentView: View {
    @State private var user = User()

    var body: some View {
        VStack {
            Text("Your name is \\(user.firstName) \\(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

```

-   위의 예시코드는 firstName이나 lastName의 값이 변경되면 전체 구조체인 User가 변경됩니다.
-   즉, 구조체는 각각이 고유한 복사본을 가지고 있어서 변경사항을 공유할 수 없기 때문에 클래스를 사용해야 합니다. → 구조체는 동일한 데이터를 공유할 수 없다.
-   하지만 클래스로 User를 변경하면 동작하지 않습니다. (텍스트필드에 입력은 가능하지만 텍스트가 업데이트 되지 않습니다.)

----------

# 3. @StateObject로 SwiftUI State 공유하는 방법

SwiftUI 데이터와 함께 클래스를 사용하려는 경우 `@StateObject`, `@ObservedObject`, `@EnvironmentObject` 3가지 프로퍼티래퍼를 사용할 수 있습니다.

> User클래스로 사용하여 공유하는 예시

```swift
/// 사용자 정보를 저장하는 구조체
class User: ObservableObject {
    @Published var firstName = "Soo"
    @Published var lastName = "Kim"
}

struct ContentView: View {
    @StateObject var user = User()

    var body: some View {
        VStack {
            Text("Your name is \\(user.firstName) \\(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

```

-   @Published를 통해 해당 프로퍼티가 변경될 때 다시 뷰를 로드해야 한다고 알립니다.
-   @StateObject를 통해 해당 클래스가 프로퍼티가 변경되는 알림을 감시하도록 하는 인스턴스를 생성합니다.
-   @StateObject로 생성하는 클래스는 ObservableObject프로토콜을 준수해야 합니다.

🚨 @StateObject는 인스턴스를 생성하는 경우에 사용하고 생성된 인스턴스를 다른 곳에서 사용하려는 경우 @ObservedObject 프로퍼티래퍼를 사용합니다.

----------

# 4. 뷰를 표시하고 숨기는 방법

SwiftUI에서 뷰를 표시하는 방법은 여러가지가 있지만, 기본적인 방법 중 하나는 sheet입니다.

기존 뷰 위에 표시되는 새로운 뷰입니다. UIKit에 모달방식 화면전환과 유사합니다.

sheet는 경고창을 표시하는 것과 유사하게 작동합니다.

1.  sheet를 표시할지에 대한 여부를 추적하는 상태값을 추가합니다.
2.  sheet를추가합니다. 상태값을 양방향바인딩을 사용하여 표시합니다.
3.  뷰를 닫으려면 @Environment를 통해 외부에서 제공된 값을 저장하는 프로퍼티를 생성합니다.

> Sheet 기본 사용 예시

```swift
struct ContentView: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Sookim")
        }
    }
    
}

struct SecondView: View {
    
    let name: String
    @Environment(\\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Hello, \\(name)!")
            Button("Dismiss") {
                dismiss()
            }
        }
    }
    
}

```

----------

# 5. onDelete()를 사용하여 항목 삭제하는 방법

SwiftUI에서는 컬렉션에서 객체를 삭제할 때 onDelete()수정자를 사용할 수 있습니다.

onDelete()는 ForEach에 사용하여 삭제할 수 있습니다.

IndexSet 자료형을 사용하여 모든 항목의 위치를 알려줍니다.

> ForEach에서 항목을 제거하는 예시

```swift
ForEach(numbers, id: \\.self) {
    Text("Row \\($0)")
}
.onDelete(perform: removeRows)

func removeRows(at offsets: IndexSet) {
    numbers.remove(atOffsets: offsets)
}

```

----------

# 6. UserDefaults로 데이터 저장하는 방법

UserDefaults에 간단한 정보데이터를 저장할 수 있습니다. UserDefaults는 앱이 시작될 때 자동으로 로드되지만, 너무 많은 값을 저장하면 앱의 실행속도가 느려집니다.(권장은 기기마다 512KB이하를 권장합니다.)

SwiftUI에서는 UserDefaults를 @AppStorage 프로퍼티래퍼를 사용하여 사용할 수 있습니다.

> UserDefaults를 사용한 예시

```swift
struct ContentView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

    var body: some View {
        Button("클릭 횟수: \\(tapCount)") {
            tapCount += 1
						UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}

```

-   UserDefault.standard : 앱에 연결된 기본 제공되는 UserDefaults 인스턴스입니다.
-   set : 모든 종류의 데이터를 허용하는 메서드입니다.
-   forKey : 데이터에 이름(키)를 첨부합니다.

<aside> 💡 단점 : 키값을 찾을 수 없는 경우 데이터를 가져올 수 없습니다. 데이터를 영구저장소에 저장하므로 딜레이가 발생합니다.

</aside>

> @AppStorage 프로퍼티래퍼를 사용한 예시

```swift
struct ContentView: View {
    @AppStorage("tapCount") private var tapCount = 0

    var body: some View {
        Button("클릭 횟수: \\(tapCount)") {
            tapCount += 1
        }
    }
}

```

-   UserDefaults시스템을 @AppStorage 프로퍼티래퍼를 통해 접근합니다. 값이 변경되면 body프로퍼티에 새로운 값을 반영합니다.
-   기본값을 제공하지만, 내부에 저장된 값이 있는 경우 내부에 저장된 값을 설정합니다.

----------

# 7. ****Codable로 Swift객체를 저장하는 방법****

Codable 프로토콜은 데이터를 저장하고 해제할 수 있도록 해줍니다.

UserDefaults에 저장할 때 JSON(JavaScript Object Notation)형식으로 인코딩하여 저장할 수 있습니다.

> UserDefaults에 객체 저장하는 예시

```swift
struct User: Codable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Soo", lastName: "Kim")

    var body: some View {
				Button("User객체 저장하기") {
				    let encoder = JSONEncoder()
				
				    if let data = try? encoder.encode(user) {
				        UserDefaults.standard.set(data, forKey: "UserData")
				    }
				}
    }
}

```

-   저장될 때 자료형은 Data자료형이라는 새로운 자료형입니다. 모든 종류의 데이터를 저장하도록 설계되었습니다.
