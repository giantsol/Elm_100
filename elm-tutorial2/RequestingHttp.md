Elm에서 HTTP request를 날리기 위해 프레임워크에서 제공하는 라이브러리로
elm-lang/http가 있다.
그리고, 위의 라이브러리로 받은 데이터 및 데이터의 상태를 나타내기 편리한 데이터타입을
제공하는 라이브러리로 krisajenkins/remotedata가 있다.
예컨대:

```elm
import RemoteData exposing (WebData)
type Msg = OnFetchPlayers (WebData (List Player))
```

위에서 OnFetchPlayers라는 함수가 HTTP request가 끝나는 시점에 불리는
함수라고 하면, 파라미터로 받는 WebData는 ```NotAsked```,
```Loading```, ```Success```, ```Failure```라는 3개의
상태를 가질 수 있고, 상태에 따라 데이터 그 자체를 지니고 있을 수도 있다.

마지막으로, NoRedInk/elm-decode-pipeline이라는 라이브러리는
JSON 데이터를 파싱하기 아주 편리하게 해준다. 예컨대:
```elm
type alias Player =
    { id: String
    , name: String
    , level: Int
    }
    
{-- players.json
{
  "players": [
    { "id": "1", "name": "Sally", "level": 2 },
    { "id": "2", "name": "Lance", "level": 1 },
    { "id": "3", "name": "Aki", "level": 5 },
    { "id": "4", "name": "Maria", "level": 3 },
    { "id": "5", "name": "Lulu", "level": 1 }
  ]
}
--}
```
players.json 파일이 있을 때, Player 데이터 타입을 똑같은 형태로 선언해주고,
```elm
playerDecoder: Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int
```
위와 같이 pipeline으로 파싱을 해주면, Player 객체애 대한 디코더가 완성된다.

