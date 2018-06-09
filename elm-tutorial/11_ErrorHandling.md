# Error Handling in Elm

Elm 언어의 목표 중 하나는 런타임 에러를 하나도 내지 않는 것이다. 실제로, NoRedInk라는 웹사이트는
Elm 언어로 구현이 되어 있는데, 만들어진지 약 1년이 지난 지금까지 단 한번도 런타임 에러가 나지 않았다고 한다.

런타임 에러를 내는 주 범인 중 하나는 역시 null이다. Null의 창시자인 Tony Hoare 스스로도 이것을 billion-dollar mistake
라고 부른다. C, Java같은 언어의 문제점은, 어떤 변수가 null이 될 수 있는지 컴파일러 단에서 잡아주지 못하고,
그래서 프로그래머가 null이 될 수 있는 포인트를 놓치면, NullPointerException이 발생할 수 있는 것이다.
Elm에서는 ```Maybe```라는 장치를 통해 이 문제를 해결한다.

또 하나의 문제는 RuntimeException 그 자체. 코드는 멀쩡해 보이고, 자바를 예로 들면
```throws XXXException```이라는 표기 사항도 없는데, 그 함수 내에서 에러가 발생할 수 있는 것이다.
Elm에서는 ```Result```와 ```Task```라는 장치를 통해 이 문제를 해결한다.


