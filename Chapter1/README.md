# 🧠 visionOS Playground Tutorials

![Platform](https://img.shields.io/badge/Platform-visionOS-blue)
![Language](https://img.shields.io/badge/Language-Swift-orange?style=flat&logo=swift&logoColor=white)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-green)

---

## Chapter 1. Windows in visionOS

### 📌 Summary

이번 챕터에서는 visionOS에서 창을 구성하고, SwiftUI의 상태 관리와 레이아웃 개념을 함께 학습했다.

기존 iOS 개발에서는 화면 전체를 기준으로 UI를 구성하는 경우가 많았지만, visionOS에서는 사용자가 공간 안에 여러 개의 창을 배치하고 크기를 조절할 수 있기 때문에 `.windowResizability`, `.frame`, `.padding3D` 같은 개념을 함께 고려해야 한다는 점이 인상 깊었다.

@State, Binding, Closure, Grid, GridRow 등을 학습하였다.

---

### 🧠 What I Learned

- SwiftUI에서 `@State`를 사용해 뷰 내부 상태를 관리하는 방법
- `$` 기호를 통해 값을 `Binding`으로 전달하는 방법
- 클로저의 기본 구조와 `in` 키워드의 역할
- visionOS에서 Z축 방향으로 여백을 주는 `.padding3D`
- `Grid`와 `GridRow`를 활용한 레이아웃 구성
- visionOS 창 크기를 제어하는 `.windowResizability(.contentSize)`
- `.frame(maxWidth:)`, `.frame(minHeight:)`를 통해 뷰 크기를 제한하는 방법
- Swift에서 숫자 타입을 다룰 때 `Double`, `Int`를 적절히 변환해야 하는 이유

---

## 🔍 Key Concepts

### `@State`

`@State`는 SwiftUI 뷰 내부에서 변할 수 있는 값을 저장하기 위한 속성 래퍼다.

```swift
@State private var colors: [Color] = [.cyan, .blue]
```

#### 역할

- **뷰의 상태 저장소 제공**
  - `@State`로 선언된 값은 SwiftUI가 별도의 저장 공간에서 관리한다.
  - 뷰가 다시 생성되더라도 상태 값은 유지된다.

- **뷰의 재렌더링 유도**
  - `@State` 값이 변경되면 SwiftUI는 이를 감지하고 해당 뷰를 다시 그린다.

#### 왜 `private`으로 선언할까?

- **데이터 소유권을 명확히 하기 위해**
  - `@State`는 해당 뷰가 직접 소유하고 관리하는 상태다.
  - 외부에서 직접 접근하거나 수정하지 못하게 하는 것이 좋다.

- **데이터 흐름을 단순하게 유지하기 위해**
  - 외부 뷰나 객체가 내부 상태를 직접 수정하면 데이터 흐름이 복잡해질 수 있다.
  - 자식 뷰에 값을 넘겨야 한다면 `Binding`을 사용하는 것이 적절하다.

---

### `$` 기호와 `Binding`

변수 이름 앞에 `$`를 붙이면 해당 값을 `Binding` 형태로 전달할 수 있다.

```swift
ColorPicker("Color", selection: $colors[0])
ColorPicker("Color", selection: $colors[1])
```

#### 차이

```swift
colors[0]
```

현재 저장된 값을 읽어오는 방식이다.

```swift
$colors[0]
```

값을 읽을 수 있을 뿐 아니라, 사용자가 화면에서 값을 변경했을 때 그 변경 사항을 다시 원본 상태에 반영할 수 있다.

즉, `Binding`은 부모 뷰가 가진 상태를 자식 뷰나 UI 컴포넌트가 수정할 수 있게 연결해주는 통로라고 볼 수 있다.

---

### Closure

클로저는 이름 없는 함수다.  
특정 동작을 한 번만 전달하거나, 함수의 인자로 실행 코드를 넘기고 싶을 때 사용한다.

```swift
{ (parameter) -> ReturnType in
    // 실행할 코드
}
```

#### `in`의 역할

`in`은 클로저의 선언부와 실행부를 나누는 기준선이다.

- `in` 앞쪽  
  - 어떤 매개변수를 받을지
  - 어떤 값을 반환할지 정의한다.

- `in` 뒤쪽  
  - 실제로 실행할 코드를 작성한다.

---

### `.padding3D`

visionOS에서는 뷰에 Z축 방향의 깊이를 고려한 padding을 줄 수 있다.

```swift
.padding3D(.back, depth)
```

#### 기존 iOS의 `ZStack`

iOS에서 `ZStack`은 여러 뷰를 평면 위에 겹쳐 쌓는 방식에 가깝다.

#### visionOS의 공간 개념

visionOS에서는 Z축, 즉 깊이 방향을 고려할 수 있다.  
`.padding3D(.back, depth)`를 사용하면 뷰의 뒤쪽 방향으로 `depth`만큼의 공간이 생긴다.

비유하자면 각 원 뒤에 투명한 기둥이 생기는 것처럼 이해할 수 있다.

---

### `Grid` / `GridRow`

`Grid`와 `GridRow`는 표 형태의 데이터를 정렬해서 보여줄 때 유용하다.

#### `VStack` / `HStack`의 한계

`VStack`과 `HStack`을 조합하면 여러 줄의 UI를 만들 수 있지만, 각 줄은 서로의 열 구조를 알지 못한다.

그래서 텍스트 길이가 달라지면 각 줄의 정렬이 어긋날 수 있다.

#### `Grid` / `GridRow`의 장점

`Grid`는 각 행의 칸들이 같은 열에 속한다는 것을 알고 있다.

예를 들어 첫 번째 `GridRow`의 첫 번째 칸과 두 번째 `GridRow`의 첫 번째 칸은 같은 열로 정렬된다.

```swift
Grid {
    GridRow {
        Text("Width")
        Text("300")
    }

    GridRow {
        Text("Height")
        Text("500")
    }
}
```

가장 긴 내용을 기준으로 열 너비가 정렬되기 때문에, 표 형태의 UI를 더 안정적으로 만들 수 있다.

---

### `.windowResizability(.contentSize)`

`.windowResizability(.contentSize)`는 `WindowGroup`에 적용하는 modifier다.

```swift
WindowGroup {
    ContentView()
}
.windowResizability(.contentSize)
```

이 modifier를 사용하면 창의 크기 조절 가능 범위가 content의 크기를 기준으로 결정된다.

- content가 가진 최소 크기 → 창의 최소 크기
- content가 가진 최대 크기 → 창의 최대 크기

visionOS에서는 사용자가 창을 공간 안에 배치하고 크기를 조절할 수 있기 때문에, content 자체의 크기 제어가 중요해진다.

---

### `.frame(maxWidth:)` / `.frame(minHeight:)`

`.frame`은 뷰의 크기 제한을 설정할 때 사용한다.

```swift
.frame(maxWidth: 500)
.frame(minHeight: 300)
```

#### 역할

- `.frame(maxWidth:)`
  - 뷰가 가질 수 있는 최대 너비를 제한한다.

- `.frame(minHeight:)`
  - 뷰가 최소한 확보해야 하는 높이를 지정한다.

이를 통해 뷰가 너무 작아지거나, 지나치게 커지는 것을 방지할 수 있다.

---

## 💡 What Was Interesting

- visionOS 시뮬레이터에서 낮과 밤의 조명 차이를 고려할 수 있다는 점이 흥미로웠다.
- iOS에서는 주로 X축과 Y축 중심으로 UI를 생각했는데, visionOS에서는 Z축 방향의 깊이까지 고려해야 한다는 점이 새로웠다.
- 기존에는 iPhone 화면을 가득 채우는 방식으로 UI를 구성했지만, visionOS에서는 창의 크기와 공간 배치까지 함께 고려해야 한다는 점이 인상적이었다.

---

## ❗ Difficulties

- 부모 뷰에서 `@State`를 관리하고, 자식 뷰에서는 `Binding`으로 값을 받아 사용하는 구조가 아직 익숙하지 않다.
- 단순한 예제에서는 `VStack`과 `HStack`만으로도 충분해 보여서, `Grid`가 반드시 필요한 UI 상황을 더 찾아봐야 한다.
- visionOS에서 content와 window의 크기를 어느 정도로 설정해야 사용자에게 편안한지 판단하는 기준이 아직 부족하다.

---

## ❓ Questions

### Swift에서 숫자 계산은 모두 `Double`로 통일하는 것이 좋을까?

항상 `Double`로 통일하는 것이 좋은 것은 아니다.

다만 서로 다른 숫자 타입을 함께 계산해야 할 때는 하나의 타입으로 변환해서 계산해야 한다.

SwiftUI에서 뷰의 크기와 관련된 값은 보통 `Double` 또는 `CGFloat`로 다뤄진다.  
반면 `ForEach`의 index는 `Int`인 경우가 많다.

따라서 index를 활용해 `.frame` 크기를 계산해야 할 때는 `Int` 값을 `Double` 또는 `CGFloat`로 변환해주는 과정이 필요하다.

```swift
let width = Double(index) * 20.0
```

핵심은 모든 숫자를 무조건 `Double`로 통일하는 것이 아니라, 계산에 필요한 타입을 명확히 맞춰주는 것이다.

---

## 🚀 Next Step

- `@State`와 `Binding`을 활용한 부모-자식 뷰 예제를 추가로 만들어보기
- `Grid`와 `GridRow`가 필요한 상황을 직접 만들어보기
- visionOS에서 window size를 어떻게 설계하면 좋은지 HIG 문서 더 읽어보기
- `.padding3D`를 활용해 깊이가 있는 UI의 쓸모 찾기
- 공간 중심인 앱은 어떤 이점을 갖는지 더 고민하기

---

