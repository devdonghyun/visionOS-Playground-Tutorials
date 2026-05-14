# 🧠 visionOS Playground Tutorials

![Platform](https://img.shields.io/badge/Platform-visionOS-blue)
![Language](https://img.shields.io/badge/Language-Swift-orange?style=flat&logo=swift&logoColor=white)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-green)

---

# Chapter 2 - Ornaments And MultipleWindows

## 📌 Summary (요약)

이번 챕터에서는 visionOS에서 여러 개의 window를 열고, 각 window에 데이터를 전달하는 방법을 학습했다.

기존 iOS 앱에서는 하나의 화면 안에서 navigation stack을 쌓아가며 이동하는 방식이 익숙했지만, visionOS에서는 사용자가 공간 안에 여러 개의 window를 동시에 띄우고 배치할 수 있기 때문에 WindowGroup, openWindow, @Environment, ornament 같은 개념을 함께 이해해야 했다.

특히 openWindow(value:)가 단순히 새 창을 여는 기능이 아니라, 어떤 타입의 window를 열지 결정하고 그 window에 전달할 데이터까지 함께 넘긴다는 점이 인상 깊었다.

@Binding, @Previewable, WindowGroup(for:), Hashable, Codable, computed property, windowStyle(.plain), ornament 등을 학습하였다.

---

## 🧠 What I Learned (배운 점)

- @Binding을 사용해 부모 뷰가 가진 상태를 자식 뷰에서 수정하는 방법
- #Preview 안에서 테스트하기 위해 @Previewable @State를 사용하는 이유
- background에 모양을 줘도 실제 뷰의 모양이 바뀌는 것은 아니라는 점
- ornament를 사용해 window 주변의 적절한 위치에 control을 배치하는 방법
- attachmentAnchor를 통해 ornament가 view 주변 어디에 붙을지 정하는 방법
- @Environment를 통해 view의 environment에서 값을 읽어오는 방법
- OpenWindowAction을 사용해 새로운 window를 여는 방법
- openWindow(value:)가 값의 타입을 보고 어떤 WindowGroup을 열지 결정한다는 점
- WindowGroup(for:)를 사용해 특정 데이터 타입을 처리하는 window를 정의하는 방법
- Label이 Hashable, Codable을 따라야 하는 이유
- Color는 Codable이 아니기 때문에 직접 저장하지 않고 colorIndex를 저장하는 방식
- computed property를 사용해 colorIndex로 실제 SwiftUI Color를 찾아오는 방법
- windowStyle(.plain)을 사용해 visionOS의 기본 window frame을 제거하는 방법
- closure property를 사용해 버튼이 눌렸을 때 실행할 동작을 외부에서 주입하는 방법

---

## 🔍 Key Concepts (핵심 개념)

### @Binding

@Binding은 부모 뷰가 가진 상태를 자식 뷰에서 읽고 수정할 수 있게 해주는 연결 통로다.

ContentView가 Label 데이터를 소유하고 있다면, LabelView는 그 데이터를 직접 소유하는 것이 아니라 Binding으로 전달받아 사용한다.

여기서 label은 실제 값이고, $label은 그 값을 수정할 수 있는 Binding이다.

이렇게 하면 LabelView 안에서 label의 값을 수정해도 실제로는 부모 뷰인 ContentView가 가진 @State label이 변경된다.

즉, @State는 상태를 소유하는 곳에 사용하고, @Binding은 그 상태를 빌려서 수정하는 곳에 사용한다.

---

### @Previewable

LabelView가 @Binding을 필요로 하게 되면 더 이상 혼자서 preview를 만들 수 없다.

Binding은 원본 상태가 있어야 만들어질 수 있기 때문에, preview 안에서도 임시로 상태를 만들어줘야 한다.

@Previewable은 #Preview 안에서 로컬 State 변수를 만들 때 사용한다.

프리뷰 안에서 사용자가 TextField, Slider 같은 UI를 조작하면 상태가 바뀌고, 그 변경 사항이 preview 화면에 다시 반영되어야 한다.

따라서 @Previewable @State는 preview 안에서 임시 부모 역할을 하는 상태를 만들어주는 방식이라고 볼 수 있다.

---

### background와 실제 View의 모양

SwiftUI에서 background에 모양을 넣으면 해당 모양이 view 뒤에 그려진다.

하지만 이것은 실제 view의 모양을 바꾸는 것이 아니다.

background는 말 그대로 뒤에 무언가를 그리는 역할을 한다. 따라서 레이아웃, 터치 영역, clipping 영역은 여전히 원래 view 기준으로 계산된다.

예를 들어 배경에 Circle을 그렸다고 해서 실제 터치 영역이 원형으로 바뀌는 것은 아니다. 보이는 모양은 원에 가까워도 실제 view가 차지하는 영역은 여전히 사각형일 수 있다.

실제 모양대로 자르려면 clipShape을 사용해야 하고, 터치 영역을 조정하려면 contentShape을 사용해야 한다.

---

### ornament

ornament는 visionOS에서 자주 필요한 control이나 정보를 window 주변의 일정한 위치에 배치할 때 사용한다.

window 내부에 버튼을 계속 넣으면 content가 복잡해질 수 있다. 하지만 ornament를 사용하면 중요한 control을 window 가까이에 두면서도 본문을 덜 어지럽힐 수 있다.

attachmentAnchor는 ornament가 view 주변 어디에 배치될지 정의한다.

.scene(.bottom)은 view의 아래쪽 중앙에 ornament를 배치한다.

.scene(.topTrailing)은 view의 오른쪽 위 모서리에 ornament를 배치한다.

ornament는 window 가까이에 머물기 때문에 사용자가 필요한 control을 어디에서 찾아야 하는지 쉽게 기억할 수 있다.

---

### HStack inside Ornament

ornament 안에 여러 control을 넣을 때 HStack을 사용하지 않으면 control들이 세로로 쌓일 수 있다.

HStack은 control들을 가로 방향으로 정렬해준다.

특히 bottom ornament에서는 control들이 window 아래쪽에 나란히 놓이는 것이 더 자연스럽다.

HStack이 없으면 control들이 세로로 쌓이면서 window contents를 가릴 수 있기 때문에, ornament 안의 control 배치도 함께 고려해야 한다.

---

### @Environment and OpenWindowAction

@Environment는 view의 environment에서 값을 읽어오기 위한 property wrapper다.

새로운 window를 열기 위해서는 openWindow 값을 environment에서 가져올 수 있다.

이 값은 OpenWindowAction이며, 새로운 window를 여는 기능을 제공한다.

openWindow(value:)는 단순히 창을 여는 것뿐 아니라, 전달된 값의 타입과 내용을 함께 사용한다.

---

### openWindow(value:)

openWindow(value:)는 두 가지 역할을 한다.

첫 번째로, 전달된 값의 타입을 보고 어떤 종류의 window를 열지 결정한다.

예를 들어 label의 타입이 Label이라면 SwiftUI는 Label 타입을 처리하는 WindowGroup을 찾는다.

두 번째로, 전달된 값의 내용을 새 window에 넘겨준다.

즉, openWindow(value:)는 “이 타입의 데이터를 가진 새 window를 열어줘”라는 요청에 가깝다.

---

### WindowGroup(for:)

WindowGroup은 앱이 보여줄 수 있는 view hierarchy를 정의한다.

기본 WindowGroup은 앱이 처음 실행될 때 보여줄 기본 window를 담당한다.

반면 WindowGroup(for:)는 특정 데이터 타입을 기반으로 열리는 window를 정의한다.

WindowGroup(for: Label.self)는 openWindow(value:)에 Label 타입의 값이 들어왔을 때 사용할 window 구조를 등록하는 것이다.

앱은 여러 개의 WindowGroup을 가질 수 있고, 각각 다른 데이터 타입을 처리할 수 있다.

즉, 하나는 앱의 기본 window를 담당하고, 다른 하나는 Label 데이터를 받아서 열리는 label window를 담당할 수 있다.

---

### Optional Value from WindowGroup

WindowGroup(for:)가 제공하는 값은 optional이다.

따라서 LabelView에 값을 넘길 때 기본값을 제공해야 컴파일러를 만족시킬 수 있다.

이것은 전달된 label 값이 있으면 그 값을 사용하고, 값이 없으면 기본 Label을 사용한다는 뜻이다.

즉, window가 열릴 때 보여줄 view는 LabelView이고, 전달된 값이 없을 가능성에 대비해 default label을 넣어주는 것이다.

---

### Hashable and Codable

openWindow(value:)로 값을 전달하려면 해당 타입이 Hashable, Encodable, Decodable을 따라야 한다.

보통 Encodable과 Decodable은 함께 묶어서 Codable로 작성한다.

Hashable은 값을 구분하고 비교할 수 있게 해준다. SwiftUI는 여러 window를 다룰 수 있기 때문에 전달된 값들을 식별할 수 있어야 한다.

Codable은 값을 저장 가능한 형태로 바꾸고, 다시 복원할 수 있게 해준다. window 상태를 저장하거나 복원해야 할 수 있기 때문에 필요하다.

Label 안의 UUID, String, Double, Int는 이미 Hashable과 Codable을 지원한다. 따라서 Swift는 필요한 함수들을 자동으로 생성해준다.

---

### ColorIndex

Label에 색상을 저장할 때 SwiftUI의 Color를 직접 저장하지 않는다.

그 이유는 Color가 Codable을 따르지 않기 때문이다.

자동 Codable conformance를 사용하려면 struct 안의 모든 property가 Codable이어야 한다. 하지만 Color는 Codable이 아니기 때문에 Label 안에 직접 넣으면 자동으로 저장하고 복원하기 어렵다.

대신 색상 배열에서 몇 번째 색을 사용하는지 나타내는 Int 값을 저장한다.

Int는 Codable을 지원하므로 Label은 계속 자동으로 Codable을 따를 수 있다.

기본값을 0으로 두면 첫 번째 색상을 기본 색상으로 사용할 수 있다.

---

### Computed Property

colorIndex만 저장하면 실제 SwiftUI Color를 사용할 때 매번 배열에서 색을 찾아와야 한다.

이를 위해 computed property를 만들 수 있다.

selectedColor는 저장된 property가 아니라, colorIndex를 바탕으로 계산되는 property다.

이 구조의 장점은 저장 가능한 값과 화면에 필요한 값을 분리할 수 있다는 점이다.

- 저장할 때는 colorIndex만 저장한다.
- 화면에 그릴 때는 selectedColor로 실제 Color를 가져온다.

---

### windowStyle(.plain)

visionOS의 window는 기본적으로 시스템이 제공하는 frame을 가진다.

하지만 label처럼 독립적인 오브젝트처럼 보여주고 싶은 view라면 기본 window frame이 어색할 수 있다.

이때 windowStyle(.plain)을 사용한다.

.plain을 적용하면 visionOS의 기본 window frame이 제거된다.

그 결과 LabelView가 하나의 일반적인 앱 창 안에 들어있는 것이 아니라, 공간 안에 독립적으로 떠 있는 것처럼 보인다.

---

### Closure Property

버튼을 custom component로 만들 때, 버튼이 눌렸을 때 실행할 동작을 외부에서 주입할 수 있다.

closure property를 사용하면 버튼은 모양만 담당하고, 실제로 눌렀을 때 무엇을 할지는 부모 뷰가 결정할 수 있다.

이렇게 하면 같은 버튼 컴포넌트를 여러 곳에서 재사용할 수 있다.

preview에서도 해당 버튼을 만들려면 action을 넘겨야 한다.

단순히 모양만 확인할 때는 빈 closure를 넣을 수 있다. 이 빈 closure는 버튼을 눌러도 아무것도 하지 않는다는 뜻이다.

---

### Keeping Style After Creating a New Label

새 label window를 연 뒤에는 현재 입력 중인 label을 새 label로 초기화할 수 있다.

이때 현재 label은 새 window로 보내고, 입력창에는 새 label을 준비한다.

중요한 점은 text는 초기화되지만, 사용자가 선택한 corner radius와 color는 유지된다는 것이다.

만약 모든 값을 기본값으로 초기화하면 사용자가 선택한 색상과 모서리 둥글기까지 모두 기본값으로 돌아간다.

하지만 여러 label을 같은 스타일로 연속해서 만들고 싶은 경우에는 불편하다.

따라서 새 label을 만들 때 이전 label의 cornerRadius와 colorIndex를 복사해두는 것이다.

---

## 💡 What Was Interesting (흥미로웠던 점)

- openWindow(value:)가 단순히 창을 여는 함수가 아니라, 값의 타입을 보고 어떤 WindowGroup을 열지 결정한다는 점이 흥미로웠다.
- visionOS에서는 하나의 화면 안에서 navigation을 쌓는 것보다, 공간 안에 여러 window를 여는 방식이 더 자연스러울 수 있다는 점이 새로웠다.
- WindowGroup을 여러 개 정의하고, 각각 다른 데이터 타입을 담당하게 만들 수 있다는 점이 인상적이었다.
- Color를 직접 저장하지 않고 colorIndex를 저장하는 방식이 좋았다. 저장 가능한 데이터와 실제 UI 표현을 분리하는 방식이 더 안전하다는 것을 알게 되었다.
- ornament를 사용하면 자주 쓰는 control을 window 안에 억지로 넣지 않아도 된다는 점이 visionOS다운 UI 설계처럼 느껴졌다.
- windowStyle(.plain)을 적용했을 때 view가 일반 window가 아니라 공간 안에 놓인 하나의 오브젝트처럼 보인다는 점이 흥미로웠다.

---

## ❗ Difficulties (어려웠던 점)

- @State, @Binding, $label의 관계가 아직 완전히 자연스럽지는 않다. 특히 부모가 상태를 소유하고 자식이 binding으로 수정한다는 흐름을 계속 연습해야 할 것 같다.
- WindowGroup(for:)에서 전달되는 값이 optional이라는 점이 헷갈렸다. 왜 기본 Label을 제공해야 하는지 이해하는 데 시간이 필요했다.
- Hashable, Codable이 왜 갑자기 필요한지 처음에는 이해하기 어려웠다. 단순히 창을 여는 것처럼 보이지만, window를 식별하고 저장 및 복원하기 위해 필요한 조건이라는 점을 알게 되었다.
- Color를 직접 저장하면 안 되고 Int index를 저장해야 한다는 점이 처음에는 우회적인 방식처럼 느껴졌다.
- background에 Shape을 넣으면 실제 view의 모양도 바뀐다고 착각하기 쉬웠다. 보이는 모양과 실제 layout, touch area, clipping 영역은 다를 수 있다는 점을 구분해야 한다.
- ornament 안에서도 HStack 같은 layout을 신경 써야 한다는 점이 생각보다 중요했다.

---

## ❓ Questions (궁금한 점)

### UUID는 정말 필요한가?

항상 필요한 것은 아니다.

하나의 LabelView에서 하나의 label만 다룬다면 UUID가 없어도 된다.

하지만 여러 label을 만들고, 각각을 별도의 window로 열거나 배열로 관리해야 한다면 고유한 식별자가 필요하다.

예를 들어 같은 text와 같은 corner radius를 가진 label이 여러 개 있을 수 있다. 이때 id가 있으면 내용이 같더라도 서로 다른 label로 구분할 수 있다.

따라서 UUID는 label이 여러 개 존재하고, 각각을 독립적으로 식별해야 하는 상황에서 유용하다.

---

### 왜 LabelView(label: $label)처럼 $를 붙여야 할까?

LabelView가 @Binding var label: Label을 요구하기 때문이다.

@Binding은 값 자체가 아니라, 값을 읽고 수정할 수 있는 연결을 필요로 한다.

따라서 부모 뷰에서는 $label을 넘겨야 한다.

label은 현재 값이고, $label은 그 값을 수정할 수 있는 binding이다.

---

### 왜 preview에서도 @Previewable @State가 필요할까?

LabelView가 @Binding을 필요로 하기 때문이다.

실제 앱에서는 ContentView가 @State를 가지고 있고, LabelView에 binding을 넘긴다.

preview에서도 똑같이 임시 상태가 필요하다.

@Previewable을 사용하면 preview 안에서도 user input에 따라 상태가 바뀌고, view가 다시 업데이트될 수 있다.

---

### Color를 그냥 Label에 저장하면 안 될까?

Color는 Codable을 따르지 않기 때문에 직접 저장하면 Label의 자동 Codable conformance를 사용할 수 없다.

대신 색상의 위치를 나타내는 index를 저장한다.

그리고 실제 색상은 static 배열에서 가져온다.

이렇게 하면 저장 가능한 모델 구조를 유지하면서도 SwiftUI에서는 편하게 Color를 사용할 수 있다.

---

### background에 둥근 사각형을 넣었는데 왜 실제 view 모양은 안 바뀔까?

background는 view 뒤에 무언가를 그리는 modifier이기 때문이다.

이것은 view 자체를 둥근 사각형으로 바꾸는 것이 아니라, view 뒤에 둥근 사각형을 그리는 것이다.

따라서 실제 clipping이 필요하다면 clipShape을 사용해야 한다.

터치 영역까지 모양에 맞추고 싶다면 contentShape을 사용할 수 있다.

---

### 왜 새 label을 만든 뒤에 corner radius와 color index를 복사할까?

사용자가 선택한 스타일을 유지하기 위해서다.

이렇게 하면 현재 label은 새 window로 보내고, 입력창에는 새 label을 준비한다.

이때 text는 초기화되지만 corner radius와 color는 유지된다.

사용자는 같은 스타일로 여러 label을 연속해서 만들 수 있다.

---

## 🚀 Next Step (다음 단계)

- @State와 @Binding을 사용하는 부모-자식 뷰 구조를 더 연습하기
- WindowGroup(for:)를 사용해 다른 데이터 타입의 window도 열어보기
- openWindow(value:)로 전달되는 값이 window 안에서 어떻게 유지되고 복원되는지 더 실험해보기
- ornament를 활용해 window 안의 content를 가리지 않는 control 배치 연습하기
- windowStyle(.plain)을 적용했을 때와 기본 window style일 때의 차이를 비교해보기
- Color처럼 직접 저장하기 어려운 UI 타입을 index나 identifier로 관리하는 패턴을 더 찾아보기
- visionOS에서 여러 window를 여는 경험이 사용자에게 정말 편한지, 어떤 상황에서 유용한지 더 고민하기

---
