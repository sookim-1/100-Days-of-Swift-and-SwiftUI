
# 1. ViewsAndModifiers 프로젝트 확장하기

1.  WeSplit프로젝트에서 사용자가 0%팁을 선택하면 조건부수정자를 사용하여 총 금액텍스트뷰를 빨간색으로 변경합니다.
    
    ```swift
    Text(totalPrice, format: currencyFormat)
                            .foregroundColor(tipPercentage == 0 ? .red : .blue)
    
    ```
    
2.  GuessTheFlag프로젝트에서 중복되는 이미지뷰를 FlagImage로 분리합니다.
    
    ```swift
    struct FlagImage: View {
        var imageName: String
        
        var body: some View {
            Image(imageName)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
        }
    }
    
    ```
    
3.  큰 파란색 폰트를 뷰로 만드는 커스텀수정자를 작성합니다.
    
    ```swift
    struct BlueTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
    }
    
    extension View {
        func setBlueTitleView() -> some View {
            modifier(BlueTitle())
        }
    }
    
    ```
