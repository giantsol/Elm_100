# Generic Data Structures

```elm
type StringList = Empty | Node String StringList
```

위와 같은 리스트는 value로 String밖에 받지 못한다. 그래서 다른 프로그래밍 언어들에도
'Generic'이라는 개념이 존재하는데, Elm에도 마찬가지로 존재한다:

```elm
type List a = Empty | Node a (List a)

Empty
-- Empty : List a

Node
-- <function> : a -> List a -> List a

Node "hi" Empty
-- Node "hi" Empty : List String

Node 1.618 (Node 6.283 Empty)
-- Node 1.618 (Node 6.283 Empty) : List Float
```

위에서 'a'가 generic 변수를 나타낸다. 'f', 'z', 'value' 등 a 대신 
아무 알파벳을 넣어도 무관하다. 단, 대문자는 포함하지 말아야 한다.

실제로, Elm의 List 구현부도 저런 식으로 구현이 되어 있다고 한다. 

