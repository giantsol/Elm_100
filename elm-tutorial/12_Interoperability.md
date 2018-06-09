# Interoperability

Elm이 웹 Front-End 개발 언어로 사용되기 위해서는, 기존에 사용되던 기술들과 자연스럽게
어우러질 수 있어야 한다. Interoperability가 보장되어야 할 가장 큰 사항 3가지:

1. JSON을 이용한 통신
2. 기존 HTML 또는 React앱에 Elm 프로그램을 삽입하는 방법
3. 기존 Javascript언어와 통신하는 방법

# JSON

JSON에서 Elm value로 변환하기 위한 Json.Decode 라이브러리가 존재한다 (반대로 Json.Encode도 존재).

```elm
import Json.Decode as Decode

Decode.decodeString Decode.int "42"
-- Ok 42 : Result String Int

Decode.decodeString Decode.bool "hello"
-- Err "Given an invalid JSON: Unexpected token h in JSON at position 0"
-- : Result.Result String Bool
```

위와 같이, Decode.decodeString 함수를 사용하여 하나의 값으로만 이루어진 JSON 파싱이 가능하다.
위 함수가 뱉어주는 값은 Result 데이터타입으로, 파싱이 성공했는지 실패했는지 여부를 알 수 있다.


