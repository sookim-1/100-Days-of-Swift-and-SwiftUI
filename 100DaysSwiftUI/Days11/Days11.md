
# 1. 접근제어자를 사용하여 접근을 제어하는 방법

<aside> 💡 접근 제어자는 코드를 작성하는 한 파일에서 다른 파일에 있는 코드에 대한 접근을 명시적으로 작성하여 이를 관리하는 것인데, 모듈과 소스파일에 따라 다른 접근을 할 수 있습니다.

</aside>

-   모듈 : 한가지 일을 수행하는 코드의 모음
    -   예시) UIKit, Foundation, target 등등
-   소스파일 : 각각의 모듈안에 있는 파일들
    -   예시) ViewController.swift, SceneDelegate.swift 등등

접근제어자는 모듈과 소스파일 기준으로 5가지로 나눌 수 있습니다.

1.  `open`, `public` : 프로젝트 내의 모든 모듈의 해당 entity에 접근할 수 있습니다.
2.  `internal` : entity가 작성된 모듈에서만 접근할 수 있습니다. → 접근제어자를 명시하지 않으면 기본적으로 `internal` 을 따릅니다.
3.  `fileprivate` - entity가 작성된 소스파일에서만 접근할 수 있도록 합니다. 서로 다른 클래스가 같은 파일안에 있고 `fileprivate`로 선언되어 있다면 둘은 서로 접근할 수 있습니다.
4.  `private` - 특정 객체에서만 사용할 수 있도록 하는 가장 제한적인 접근제어자입니다. `fileprivate`과 달리 같은 파일 안에 있어도 서로 다른 객체가 `private`로 선언되어 있다면 둘은 서로 접근할 수 없습니다.

> open과 public의 차이

1.  open은 다른 모듈에서 subclass가 가능합니다. 하지만, public은 불가능합니다.
2.  open은 클래스에만 사용될 수 있습니다.

> 기타 사항

⚠️ UnitTest는 `@testable` 키워드로 모듈을 import하여 public과 open이 아닌 entity들을 사용할 수 있도록 해줍니다.

⚠️ Getter와 Setter에는 서로 다른 접근제어자를 적용할 수 있습니다. → 단, Setter가 접근제어자의 범위가 더 제한적이여야 합니다.

-   private(set) var ~ : getter는 구조체의 접근제어자를 따르고 setter는 private접근제어자를 따릅니다.

# 2. static 프로퍼티 및 메서드

구조체는 기본적으로 값을 복사하여 동일한 자료형의 다른 구조체의 값을 읽지 않도록 하지만, 특정 인스턴스가 아닌 구조체 자체의 프로퍼티나 메서드를 직접 사용하고 싶은 경우 `static` 키워드를 사용합니다.

> static과 non-static을 같이 사용하기 위한 규칙

1.  static코드에서 non-static코드에 접근하는 것을 지양해야합니다.
2.  non-static코드에서 static코드에 접근하려면 Self키워드를 사용해야 합니다.

🤔 `self` 와 `Self` 의 차이?

`self` 는 구조체의 현재 값을 참조하는 키워드이고, `Self` 는 현재 자로형(타입)을 참조하는 키워드입니다.

# 참고링크

-   **Swift 접근 제어자(Access Control) -** [](https://hcn1519.github.io/articles/2018-01/Swift_AccessControl)[https://hcn1519.github.io/articles/2018-01/Swift_AccessControl](https://hcn1519.github.io/articles/2018-01/Swift_AccessControl)
