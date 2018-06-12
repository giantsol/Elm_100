# The pipe operator

```elm
add 1 (multiply 2 3)
```

위처럼, 함수의 적용 순서를 달리 하고 싶으면 ()으로 감싸야한다. 그런데, 적용하고자 하는 함수가 여러개가 되면, 위처럼 썼을때 가독성이 많이 떨어질 수 있다.

```elm
sum (filter (isOver 100) (map getCost records))
```

가독성이 떨어지는 이유는, 위 식을 해석하기 위해 안에서 밖으로 거꾸로 계산해야 하기 때문이다. 이런 어려움을 극복하기 위해 Elm에는 pipe operator가 존재한다.

```elm
3
    |> multiply 2
    |> add 1

records
    |> map getCost
    |> filter (isOver 100)
    |> sum
```

pipe operator를 사용하면, 기존에 우리가 코드를 읽는 방식과 동일하게 위에서 밑으로 순서대로 읽어나가면 된다. 즉, 첫번째 예제를 예로 들면, 3에 2를 multiply하고, 그 결과에 1을 add한다 라고 읽을 수 있는 것이다.

# Unit Type

```()```을 unit type이라고 한다. Unit type은 String, Int와 같은 데이터 타입으로,
'아무것도 없다'라는 () 값 만을 가질 수 있는 타입이다. 예컨대:

```elm
type alias Message a =
    { code: String
    , body: a
    }
    
readMessage: Message () -> String
readMessage message = ...
```

위의 코드에서, readMessage 함수에 파라미터로 넣을 수 있는 것은 ```Message "any-string" ()``` 객체밖에 없다.
```Message "any-string" []```, ```Message "any-string" ""``` 등 '()' 외의
 어떠한 값도 대신해서 들어갈 수 없다. 즉, unit type은 ()라는 하나의 값만 가질 수 있는 타입이다.
