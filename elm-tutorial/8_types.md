# Anonymous functions
```
> \n -> n / 2
<function> : Float -> Float
```

```\ (backslash)```부터 ```->```까지 파라미터를 정의하고, 화살표 뒤는 이 함수의 결과물이다.

```
> (\n -> n / 2) 128 -- 다른 언어들의 람다 함수와 똑같이 바로 사용 가능
64: Float
> half = \n -> n / 2 -- anonymous function에 이름을 줄 수도 있음. half n = n / 2 와 동일한 기능
<function> : Float -> Float
```

재밌는 점은, Elm에서 우리가 ```half n = n / 2```식으로 정의하는 함수들은 실제로 모두 anonymous function으로 구현되어 있다는 것이다.
```
> divide x y = x / y
<function> : Float -> Float -> Float

> divide x = \y -> x / y
<function> : Float -> Float -> Float

> divide = \x -> (\y -> x / y)
<function> : Float -> Float -> Float
```

# Declaring types
Elm이 내재적으로 type inference를 통해 변수, 함수 등의 타입들이 matching하는지 체크하지만,
우리가 명시적으로 type들을 지정해줄 수 있다.

```elm
url: String
url = "https://www.google.com"

half: Float -> Float
half n = n / 2
```

명시적으로 type을 쓸 때에는 해당 변수/함수의 바로 윗 줄에 써준다.

# Type Alias
type alias는 어떠한 타입을 다른 이름으로 사용할 수 있도록 별명을 지어주는 것과 비슷하다.
```elm
type alias Name = String

myName: Name
myName = "Hansol"
```
위의 예제에서, 결국 Name이라는 타입은 String과 같은 타입이지만, 다른 이름으로 부를 수 있게끔 해준다.
더 유용한 예시는:

```elm
hasBio : { name : String, bio : String, pic : String } -> Bool
hasBio user =
  String.length user.bio > 0
```

hasBio라는 함수는, 유저를 파라미터로 받았을 때, 그 유저가 valid bio를 가지고 있는 체크하는 함수라고 하자.
현재 User라는 타입은 name, bio, pic 이 3개의 변수밖에 없지만, 갯수가 10개, 20개 이상으로 늘어나게 되면
위와 같이 쓰기가 어려워진다.

```elm
type alias User =
  { name : String
  , bio : String
  , pic : String
  }
  
hasBio : User -> Bool
hasBio user =
  String.length user.bio > 0
```

따라서, 위와 같이 User라는 type alias를 선언해 주면, hasBio 함수의 선언이 아주 간단해진다.

# Union Types
기타 프로그래밍 언어들은 int, String 등 주어진 타입들만을 이용해서 클래스를 새로 정의하든 뭐든 하면서 프로그램을 짜도록 되어 있다.
근데 이 방식으로 짜다보면 (거의) 필연적으로 null, 또는 null을 안쓰겠다는 명분으로 
"" (empty string), [] (empty list) 과 같은 nullish한 값들을 사용하게 된다.
하지만 이런 값들을 컴파일러 단에서 강제를 하는 것은 아니고, 그냥 프로그래머가 자신만의
규칙을 세워서 하는 것이다 보니, 때로는 ""를 썼다가 때로는 null을 썼다가 하게 되는 경우가 많다.
그래서 코드가 커질수록 이것저것 뒤섞인 이상한 혼합물이 되는 기분이다..

하지만, Elm의 Union Type을 사용하면 컴파일러 단에서 위와 같은 상황들을 잡아줄 수 있다.
예컨대:
```elm
type NameType = Person | Animal | Unknown

type alias Name = 
    { 
    nameType: NameType
    , value: String
    }

james = Name Person "James"
mungmung = Name Animal "mungmung"
britcattelina = Name Unknown "britcattelina"
woshiwizniblibe = Name "" "woshiwizniblibe" -- Compile error!
```

그래서 위의 예시를 보면, java같은 언어에서 흔히 할 수 있는 실수가,
nameType이라는 String 변수가 없을 때, 프로그래머에 따라 null을 넣을 수도 있고
""을 넣을 수도 있다는 것이다 (@Nullable annotation을 쓰면 어느정도 강제는 되지만 암튼).
반면, Elm에서는 저 마지막 줄 코드에서는 compile error가 날 것이고, 따라서
코드가 확장됨에 따라 코드가 이상한 혼합물이 되는 것을 방지할 수 있다.

