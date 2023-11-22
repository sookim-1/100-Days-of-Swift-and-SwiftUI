
# 1. MoonShot 마무리

-   `GeometryReader` 를 사용하여 공간을 최대한 활용하기 위해 정확한 크기를 얻었습니다.
    -   `GeometryReader` 는 뷰의 컨테이너 크기를 읽을 수 있습니다.
-   ScrollView를 사용하였습니다.
-   레이아웃 우선순위 값이 높을 수록(Higher layout priority) 뷰가 컨테이너에 공간이 더 할당될 가능성이 큽니다. 또한 필요한 것보다 더 작은 공간에 압축될 가능성이 적습니다.
-   scaledToFit() 과 aspectRatio(contentMode: .fit)은 동일합니다.
-   모든 뷰의 레이아웃 우선순위는 기본값은0입니다. 따라서 컨텐츠 크기에 따라 공간을 균등하게 나눕니다.
-   first(where:)는 조건과 일치하는 객체를 반환합니다.
-   buttonStyle()을 사용하여 NavigationLink를 강조할 수 있습니다.
-   Navigation Link는 NavigationView와 함께 작동합니다.
-   `frame(maxWidth: .infinity)` 를 사용하여 사용가능한 모든 화면 너비를 차지하도록 설정할 수 있습니다.

# 2. MoonShot 확장하기

1.  MissionView 뱃지 이미지 아래에 날짜를 표시합니다.
    
    ```swift
    Text(mission.formattedLaunchDate)
    
    ```
    
2.  MissionView의 뷰를 분리합니다.
    
    ```swift
    // MARK: - Crew View
    struct CrewHorizontalScrollView: View {
        
        let crew: [MissionView.CrewMember]
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \\.role) { crewMember in
                        NavigationLink {
                            AstronautView(astronaut: crewMember.astronaut)
                        } label: {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                    )
    
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        
    }
    
    // MARK: - 구분선
    struct DivedView: View {
        var body: some View {
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.lightBackground)
                .padding(.vertical)
        }
    }
    
    ```
    
3.  ContentView를 List와 Grid를 변경할 수 있도록 합니다.
    
    ```swift
    struct ContentView: View {
        
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        let missions: [Mission] = Bundle.main.decode("missions.json")
        @State private var showingGrid: Bool = false
        
        var body: some View {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("My Group")
        }
    }
    
    struct GridLayout: View {
        
        let astronauts: [String: Astronaut]
        let missions: [Mission]
        
        let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
        
        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
    
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                            .padding()
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            }
        }
    }
    
    struct ListLayout: View {
        
        let astronauts: [String: Astronaut]
        let missions: [Mission]
        
        var body: some View {
            NavigationView {
                List(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                    .padding()
                    
                }
                .padding([.horizontal, .bottom])
                .listStyle(.plain)
                
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            }
        }
    }
    
    ```
