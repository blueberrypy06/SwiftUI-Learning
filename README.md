# SwiftUI-Learning
[Hacking with Swift - 100 Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui)를 기반으로 Swift 및 SwiftUI를 학습하며 작성한 실습 프로젝트, 도전 과제, 개인적인 개선 사항을 기록하는 저장소입니다.

## 학습 목표
- Swift 및 SwiftUI의 핵심 문법과 동작 원리 이해
- 선언형 UI 구성 및 상태 관리 방식 학습
- 데이터 저장, 화면 전환, 애니메이션 등 iOS 앱 개발 기술 습득
- 학습한 내용을 바탕으로 독립적인 iOS 앱 설계 및 구현 능력 향상
- 지속적인 리팩터링을 통한 코드 품질 개선

## 학습 진행도

![Progress](https://img.shields.io/badge/Progress-37%2F100-2ea44f)

- 현재 진도: Day 37

## 개발 환경
- **Language:** Swift
- **Framework:** SwiftUI
- **IDE:** Xcode
- **Platform:** iOS

## 학습 목차 (Day 16 ~ Day 37)

| 구분 | 프로젝트 | 주요 학습 내용 | 분류 | 상태 |
| :--- | :--- | :--- | :--- | :--- |
| Day 16–18 | [WeSplit](./WeSplit/README.md) | `@State`, `Form`, `NavigationStack`, `Picker` 양방향 바인딩 | Project 1 | 완료 |
| Day 19 | [UnitShift](./UnitShift/README.md) | `@FocusState`, `Segmented Picker`, 단위 변환 연산 로직 | 챌린지 과제 | 완료 |
| Day 20–22 | [GuessTheFlag](./GuessTheFlag/README.md) | `VStack`/`HStack`/`ZStack` 레이아웃, 그라데이션, `Alert` 상태 제어 | Project 2 | 완료 |
| Day 23–24 | [ViewsAndModifiers](./ViewsAndModifiers/README.md) | 뷰 합성(View Composition), 커스텀 `ViewModifier`, `@ViewBuilder` | Project 3 | 완료 |
| Day 25 | [RockPaperScissors](./RockPaperScissors/README.md) | 조건부 뷰 렌더링, 게임 턴 및 점수 상태 관리 | 마일스톤 과제 | 완료 |
| Day 26–28 | [BetterRest](./BetterRest/README.md) | `Stepper`, `DatePicker`, `DateComponents`, CoreML 회귀 모델 연동 | Project 4 | 완료 |
| Day 29–31 | [WordScramble](./WordScramble/README.md) | `List`, 앱 번들(`Bundle`) 리소스 로딩, `UITextChecker` 문자열 검증 | Project 5 | 완료 |
| Day 32–34 | [Animations](./Animations/README.md) | 암시적/명시적 애니메이션(`withAnimation`), 커스텀 트랜지션, `DragGesture` | Project 6 | 완료 |
| Day 35 | [Times Table](./TimesTable/README.md) | 동적 문제 생성 로직, `ForEach` 기반 다중 선택 UI 구성 | 마일스톤 과제 | 완료 |
| Day 36-37 | [iExpense](./iExpense/README.md) | `@Observable` 클래스 상태 공유, `.sheet()` 모달, `UserDefaults` 데이터 저장, Identifiable, UUID | Project 7 | 진행 중 |

## 저장소 구조 및 관리 기준
- 모든 실습 프로젝트는 최상위 루트의 단일 `.git` 저장소로 통합 관리합니다.
- 빌드 캐시(`DerivedData`) 및 개인 워크스페이스 설정(`xcuserdata`)은 루트 경로의 `.gitignore`를 통해 제외합니다.
