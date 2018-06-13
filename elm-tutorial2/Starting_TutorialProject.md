elm-reactor는 elm파일들에 대한 빠른 디버깅에는 유용하나,
외부의 css/js들을 사용하지는 못한다는 단점이 있다. 그래서 큰 프로젝트를 진행하기 위해서는
elm-reactor에만 의존할 수 없고, 다른 빌드 시스템을 써야하는데, 우리는 Webpack을 사용하기로 한다.

Webpack은 쉽게 말해, starting node (e.g. index.html)부터 시작해서,
그 파일이 필요로하는 여타 js/css/elm 등의 파일들을 모두 번들링하여 빌드해주는 툴이다.

