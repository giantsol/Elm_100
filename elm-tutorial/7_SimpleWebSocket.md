이번 튜토리얼은 Elm에서 WebSocket을 이용해서 아주 간단한 실시간 채팅 환경을 구현해 본다.

이를 간단히 구현하기 위해 WebSocket이라는 모듈을 제공하는데, 
이 모듈을 이용하면 아주 간단하게 WebSocket을 통해 메시지를 보내고, 
또한 이 웹소켓에 subscribe함으로써 불시적으로 메시지들을 전달받을 수 있다.
 
 ```elm
wsUrl = "ws://echo.websocket.org"

-- Subscriptions
subscriptions: Model -> Sub Msg
subscriptions model =
    WebSocket.listen wsUrl NewMessage
```
일단, 해당 웹소켓에 subscribe하는 것은 위 과정으로 끝난다.
wsUrl로 메시지가 들어올 때 마다 NewMessage라는 Msg가 불리며, 그에 따라 update 함수가 실행된다.

```elm
update: Msg -> Model -> (Model, Cmd Msg)
update msg { input, messages } =
    case msg of
        ... (생략)
        
        Send ->
            (Model "" messages, WebSocket.send wsUrl input)

        NewMessage str ->
            (Model input (str :: messages), Cmd.none)

        ... (생략)
```
위 update 함수에서 NewMessage라는 메시지는 WebSocket을 통해 새로운 값들이 들어올 때 마다 불리며, 
```str :: messages```라는 statement에서 볼 수 있듯이, 새로 들어온 문자열을 messages라는 리스트에 추가한다.

Send라는 메시지는 우리가 메시지를 입력하는 input 필드에서 엔터를 눌렀을때 생성되며,
```WebSocket.send```라는 함수를 통해 해당 url로 메시지를 전송한다.