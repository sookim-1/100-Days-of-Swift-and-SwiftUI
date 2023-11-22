# 1. Codable 사용하여 딕셔너리 형식의 JSON 파싱하기

-   JSON
    
    ```swift
    {
        "grissom": {
            "id": "아이디",
    		"name": "이름",
    		"description": "설명"
    	},
		"grissom1": {
            "id": "아이디1",
    		"name": "이름1",
    		"description": "설명1"
    	},
    }
    
    ```
    
-   Codable 구조체
    
    ```swift
    struct Astronaut: Codable, Identifiable {
        let id: String
        let name: String
        let description: String
    }
    
    ```
    
    -   Codable구조체에 Identifiable을 채택하여 배열등에서 사용할 수 있도록 합니다.
    -   id값을 기준으로 고유함을 증명합니다.
    
    > Bundle에서 파일 로드할 때 편리하게 사용하는 Extension
    
    ```swift
    extension Bundle {
        
        func decode(_ file: String) -> [String: Astronaut] {
            // 1. 번들에서 경로를 가져옵니다.
            guard let url = self.url(forResource: file, withExtension: nil) else {
                fatalError("Failed to locate \\(file) in bundle.")
            }
    
            // 2. 경로를 이용하여 데이터를 가져옵니다.
            guard let data = try? Data(contentsOf: url) else {
                fatalError("Failed to load \\(file) from bundle.")
            }
    
            // 3. 가져온 데이터를 디코딩합니다.
            let decoder = JSONDecoder()
    
            guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else {
                fatalError("Failed to decode \\(file) from bundle.")
            }
    
            return loaded
        }
        
    }
    
    ```
    
    # 2. Generic을 사용하여 모든 타입의 Codable 로드하는 방법
    
    -   JSON
        
        ```swift
        [
        	{
        		"id": 1,
        		"crew": [
                    {
                        "name": "grissom",
                        "role": "Command Pilot"
                    },
                    {
                        "name": "white",
                        "role": "Senior Pilot"
                    },
                    {
                        "name": "chaffee",
                        "role": "Pilot"
                    }
        		],
        		"description": "설명"
        	},
        	{
        		"id": 7,
                "launchDate": "1968-10-11",
        		"crew": [
                    {
                        "name": "schirra",
                        "role": "Commander"
                    },
                    {
                        "name": "eisele",
                        "role": "Command Module Pilot"
                    },
                    {
                        "name": "cunningham",
                        "role": "Lunar Module Pilot"
                    }
        		],
        		"description": "설명2."
        	}
        ]
        
        ```
        
    -   Codable 구조체
        
        ```swift
        struct Mission: Codable, Identifiable {
            
            struct CrewRole: Codable {
                let name: String
                let role: String
            }
        
            let id: Int
            let launchDate: String?     // 있을 수도 있고 없을 수도 있기 때문에 옵셔널 처리 (없다면 생략)
            let crew: [CrewRole]
            let description: String
        }
        
        ```
        
    
    > Bundle에서 파일 로드할 때 편리하게 사용하는 Extension (Generic)
    
    ```swift
    extension Bundle {
        
        func decode<T: Codable>(_ file: String) -> T {
            // 1. 번들에서 경로를 가져옵니다.
            guard let url = self.url(forResource: file, withExtension: nil) else {
                fatalError("Failed to locate \\(file) in bundle.")
            }
    
            // 2. 경로를 이용하여 데이터를 가져옵니다.
            guard let data = try? Data(contentsOf: url) else {
                fatalError("Failed to load \\(file) from bundle.")
            }
    
            // 3. 가져온 데이터를 디코딩합니다.
            let decoder = JSONDecoder()
    
            guard let loaded = try? decoder.decode(T.self, from: data) else {
                fatalError("Failed to decode \\(file) from bundle.")
            }
    
            return loaded
        }
        
    }
    
    ```
    
    # 3. 날짜 Decoding하는 방법
    
    JSONDecoder에는 **dateDecodingStrategy라는 날짜(Date)를 디코딩할 수 있는 프로퍼티가 있습니다.**
    
    DateFormatter를 사용하여 포맷형식을 정한 후 제공하면 됩니다.
    
    > 날짜 Format 지정 후 디코딩하는 예시
    
    ```swift
    let decoder = JSONDecoder()
    
    let formatter = DateFormatter()
    formatter.dateFormat = "y-MM-dd"
    decoder.dateDecodingStrategy = .formatted(formatter)
    
    guard let loaded = try? decoder.decode(T.self, from: data) else {
        fatalError("Failed to decode \\(file) from bundle.")
    }
    
    ```
    
    💡 팁 : mm은 분을 의미하고 MM은 월을 의미합니다.
    
    # 4. 커스텀컬러 편리하게 사용하는 방법
    
    > ShapeStyle Extension하여 사용하는 예시
    
    ```swift
    extension ShapeStyle where Self == Color {
        static var darkBackground: Color {
            Color(red: 0.1, green: 0.1, blue: 0.2)
        }
    
        static var lightBackground: Color {
            Color(red: 0.2, green: 0.2, blue: 0.3)
        }
    }
    
    ```
    
    -   ShapeStyle프로토콜은 background수정자가 사용하는 것이지만 Color로 사용되는 경우 조건을 명시합니다.
    -   `preferredColorScheme` 를 사용하면 다크모드를 표시할 수 있습니다.
