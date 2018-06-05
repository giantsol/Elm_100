# Subscriptions
이번 튜토리얼 6장에서 배우는 SimpleClock은, Elm 아키텍쳐에서 어떠한 이벤트에 대한 observing을 어떻게 하는지를 연습한다.

즉, 우리가 필요할 때 데이터를 요청해서 받는 것이 아닌 (eg. 필요할 때 HTTP request 날리기), 어떠한 이벤트에 대해 필요할 때 한 번 등록해두면, 그 이벤트가 발생할 때 마다 notify받을 수 있는 '옵저버 패턴'을 구현해본다.

이 옵저버 패턴은 Elm에서 'subscription'이라 불리는 구성 요소로 구현이 되어 있다. 예컨대:
```elm
subscriptions: Model -> Sub Msg
subscriptions model =
    Time.every second Tick
```
위와 같은 식으로 subscriptions을 만들어 두면, 매 초 마다 **Tick**이라는 update function이 불리고, 그 여파로 model의 데이터가 바뀌면서 최종적으로 view에 반영이 되는 것이다.

# Debug
자바스크립트의 console.log 기능은 Elm에서 Debug.log로 사용 가능하다.
```elm
import Debug exposing (log)
temp = Debug.log "Logging statement" "return val"
```
위의 코드가 실행되면, 브라우저의 콘솔에 "Logging statement: return val"이 찍히고,
temp라는 변수에는 "return val"이라는 String이 들어가게 된다.

