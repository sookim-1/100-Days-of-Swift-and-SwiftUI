
# 1. Cupcake Corner 프로젝트 마무리

간단하게 정리하면 SwiftUI의 Form, Picker, Stepper, Navigation 등등을 UI를 구현합니다. 사용자의 데이터를 서버로 전송하고 응답을 처리합니다.

-   커스텀타입의 모든 프로퍼티가 Codable을 채택하고 있다면 커스텀타입은 Codable을 채택할 수 있습니다.
-   disabled()수정자에 true가 주어지면 연결된 뷰는 UserInteraction이 비활성화 됩니다.
-   Swift의 배열은 제네릭을 사용합니다. 따라서 타입이 지정되지 않은 배열은 생성할 수 없습니다.

# 2. Cupcake Corener 확장하기

1.  주소입력화면에서 공백이 없도록 유효성 검사를 추가합니다.
2.  네트워크 연결이 실패한 경우 알림을 표시합니다.
3.  데이터모델을 클래스에서 구조체로 변환해 봅니다.
