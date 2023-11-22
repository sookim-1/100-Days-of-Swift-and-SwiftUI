
# 1. ScrollView와 GeometryReader를 함께 사용하는 방법



> 해당 화면 구현 예시

```swift
struct MissionView: View {
    let mission: Mission

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)

                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

```

-   레이아웃 측면에서 Image를 최적화하기 위해서 GeometryReader를 사용할 때 ScrollView위에 사용합니다.
-   이미지와 텍스트들의 정렬을 다르게 하기 위해 VStack 내부에 VStack을 추가합니다.

# 2. 서로 다른 JSON파일에서 가져온 Codable 데이터 일치시키는 방법

1.  다른 Codable타입을 가지는 구조체를 추가합니다.
    
    ```swift
    struct CrewMember {
        let role: String
        let astronaut: Astronaut // Codable
    }
    
    ```
    
2.  이니셜라이저를 통해 일치하는 데이터가 전달된 경우에만 인스턴스를 생성합니다.
    
    ```swift
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
    
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \\(member.name)")
            }
        }
    }
    
    ```
    

# 3. SwiftUI에서 구분선 표시하기

> 구분선 표시하는 예시

```swift
Rectangle()
    .frame(height: 2)
    .foregroundColor(.lightBackground)
    .padding(.vertical)

```
