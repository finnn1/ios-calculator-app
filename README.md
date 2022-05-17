# 계산기 프로젝트 (Finnn)

# 목차 📚
* [프로젝트 소개](#프로젝트-소개-📝)
* [UML](#UML)
* [[STEP 1] 기능구현 및 코드설명](#[STEP-1]-기능구현-및-코드설명-🧑‍🏫)
    * [[STEP 1] 고민한점 및 해결방안](#[STEP-1]-고민한점-및-해결방안-🤔)
    * [[STEP 1] 배운개념](#STEP-1-배운개념-💡)
<br/>

# 프로젝트 소개 📝
> 언제나 사용하던 계산기를 직접 구현해보는 프로젝트입니다.

<br/>

# UML 📊
<img width="100%" src="https://user-images.githubusercontent.com/87175392/168752068-44c4ee85-e427-4444-ba51-5603cb869289.jpg"/>

<br/>
<br/>

# [STEP 1] 기능구현 및 코드설명 🧑‍🏫
- `LinkedList` : 이중 연결리스트 형태의 구조체
-> `pushBeforeHead` : head의 앞쪽으로 데이터를 추가하는 메서드
-> `pushAfterTail` : tail의 뒷쪽으로 데이터를 추가하는 메서드
-> `popHead` : head 위치의 데이터를 꺼내는 메서드
-> `popTail` : tail 위치의 데이터를 꺼내는 메서드
-> `peekHead` : head 위치의 데이터를 꺼내지 않고, 보여주기만 하는 메서드
-> `peekTail` : tail 위치의 데이터를 꺼내지 않고, 보여주기만 하는 메서드
-> `isEmpty` : 리스트가 비어있는지 확인하는 메서드
-> `remove(ofIndex:)` : 원하는 위치의 데이터를 제거하는 메서드
- `CalculatorItemQueue` : 선입선출 방식의 일반적인 큐 구조체
-> `push` : 큐에 데이터를 추가하는 메서드
-> `pop` : 선입선출 형태로 데이터를 꺼내는 메서드
-> `peek` : 데이터를 꺼내지 않고, 가장 먼저넣은 데이터를 보여주기만 하는 메서드
-> `isEmpty` : 리스트가 비어있는지 확인하는 메서드

<br/>

# [STEP 1] 고민한점 및 해결방안 🤔
## 고민한점
### 1. Unit Test의 단위
TDD 방식을 이번에 처음 경험해봐서, 테스트 케이스를 어느 정도로 세분해야 되는지 고민했습니다. 고민 끝에 UML을 먼저 작성한 후, 해당 UML에 맞춰 테스트 케이스를 작성하는 방법으로 결정했습니다.
<br/>

### 2. 리스트의 기능구현
요구사항에 이번 스탭에서 리스트와 큐의 내부구현이 자율로 되어있어, 어느정도의 기능까지 구현해야할지 고민이 되었습니다. UML을 작성하며, 기능들을 추리는 방법으로 구현했습니다.
<br/>

# [STEP 1] 배운개념 💡

- `Sequence, IteratorProtocol` : 일반적인 컬렉션타입 처럼 반복문과 같은 기능들을 사용할 수 있도록 해준다.
- `ExpressibleByArrayLiteral` : [1, 2, 3] 과 같은 배열리터럴 형태를 사용할 수 있도록 해준다.
- `CustomStringConvertible, CustomDebugStringConvertible` : print() 및 dump() 등 디버그 상황에서 출력되는 데이터를 설정할 수 있다.

<br/><br/>
