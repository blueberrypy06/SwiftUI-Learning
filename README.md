# SwiftUI-Learning

Swift 및 SwiftUI의 핵심 문법과 화면 구성, 상태 관리 방식을 익히기 위해 작성한 실습 프로젝트 아카이브입니다.

## 개발 환경
- **Language:** Swift
- **Framework:** SwiftUI
- **IDE:** Xcode

## 학습 목차 (Day 16 ~ Day 37)

| 구분 | 프로젝트 | 주요 학습 내용 | 비고 |
| :--- | :--- | :--- | :--- |
| Day 16–18 | [WeSplit](./WeSplit) | `@State`, `Form`, `NavigationStack`, `Picker` 양방향 바인딩 | Project 1 |
| Day 19 | [UnitShift](./UnitShift) | `@FocusState`, `Segmented Picker`, 단위 변환 연산 로직 | 챌린지 과제 |
| Day 20–22 | [GuessTheFlag](./GuessTheFlag) | `VStack`/`HStack`/`ZStack` 레이아웃, 그라데이션, `Alert` 상태 제어 | Project 2 |
| Day 23–24 | [ViewsAndModifiers](./ViewsAndModifiers) | 뷰 합성(View Composition), 커스텀 `ViewModifier`, `@ViewBuilder` | Project 3 |
| Day 25 | [RockPaperScissors](./RockPaperScissors) | 조건부 뷰 렌더링, 게임 턴 및 점수 상태 관리 | 마일스톤 과제 |
| Day 26–28 | [BetterRest](./BetterRest) | `Stepper`, `DatePicker`, `DateComponents`, CoreML 회귀 모델 연동 | Project 4 |
| Day 29–31 | [WordScramble](./WordScramble) | `List`, 앱 번들(`Bundle`) 리소스 로딩, `UITextChecker` 문자열 검증 | Project 5 |
| Day 32–34 | [Animations](./Animations) | 암시적/명시적 애니메이션(`withAnimation`), 커스텀 트랜지션, `DragGesture` | Project 6 |
| Day 35 | [Times Table](./Times%20Table) | 동적 문제 생성 로직, `ForEach` 기반 다중 선택 UI 구성 | 마일스톤 과제 |
| Day 36-37 | [iExpense](./iExpense) | `@Observable` 클래스 상태 공유, `.sheet()` 모달, `UserDefaults` 데이터 저장, Identifiable, UUID | Project 7 (진행 중) |

## 저장소 구조 및 관리 기준
- 모든 실습 프로젝트는 최상위 루트의 단일 `.git` 저장소로 통합 관리합니다.
- 빌드 캐시(`DerivedData`) 및 개인 워크스페이스 설정(`xcuserdata`)은 루트 경로의 `.gitignore`를 통해 제외합니다.
