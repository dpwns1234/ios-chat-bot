# 🤖 AI 챗봇 앱
> OpenAI의 API를 이용하여 인공지능과 채팅하는 애플리케이션 

<br/>

## 🌲 목차
- 프로젝트 참여자 
- 프로젝트 기간
- 구현 화면
- 디렉토리 구조
- 핵심 구현사항
- 트러블 슈팅
<br/>

## 👨🏻‍💻 프로젝트 참여자

| 프로필 사진 | <a href="https://github.com/comdori-wj"> <img src="https://avatars.githubusercontent.com/u/22284092?v=4" width="90" height="90"></a> | <a href="https://github.com/dpwns1234"><img src="https://avatars.githubusercontent.com/u/52391722?v=4" width=90></a> |
| ---- | --------- | --------- |
| in Github | [@Comdori](https://github.com/comdori-wj) | [@dpwns1234](https://github.com/dpwns1234) |
| in SeSAC | Comdori | 요한 |

<br/>

## 📆 프로젝트 기간
> 2024.01.02 ~ 2024.01.26 (4 weeks)

<br/>

## 📸 구현 화면

|채팅창, 대화 연속성 테스트|긴 대화 내용 및 마지막 대화 내용 자동 스크롤|채팅 동적 입력 테스트|
|:---:|:---:|:---:|
![채팅창, 대화 연속성](https://github.com/tasty-code/ios-chat-bot/assets/22284092/dd2e06cc-79a9-4625-91f1-959980d1719b)|![긴 대화 내용 및 마지막 대화 내용 자동 스크롤](https://github.com/tasty-code/ios-chat-bot/assets/22284092/19284e7d-5e9e-494e-a4ab-0fbf6b97e3ce)|![채팅 동적 입력 테스트](https://github.com/tasty-code/ios-chat-bot/assets/22284092/a8d1da1d-2c00-40bc-875b-634c869fc196)|
|아이폰 키보드 테스트|사용자 오류 알림|
![아이폰 키보드 테스트](https://github.com/tasty-code/ios-chat-bot/assets/22284092/9288deae-a82e-4497-9fb6-057631697e49)|![사용자 오류 알림](https://github.com/tasty-code/ios-chat-bot/assets/22284092/e18cfd91-fceb-4264-b45f-9c36600cea47)|

<br/> 


## 📁 디렉토리 구조 

```
├── ChatBot
│   ├── ChatBot
│   │   ├── APIKey.plist
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   └── Contents.json
│   │   │   └── Contents.json
│   │   ├── Base.lproj
│   │   │   └── LaunchScreen.storyboard
│   │   ├── ChatAPI.swift
│   │   ├── ChatViewController.swift
│   │   ├── Extensions
│   │   │   ├── Bundle+Extension.swift
│   │   │   ├── UIStackView+Extension.swift
│   │   │   └── UITextView+Extensions.swift
│   │   ├── Info.plist
│   │   ├── Models
│   │   │   ├── Chat.swift
│   │   │   ├── ChatRequestModel.swift
│   │   │   ├── ChatResponseModel.swift
│   │   │   ├── Errors.swift
│   │   │   ├── Message.swift
│   │   │   └── Sender.swift
│   │   ├── Network
│   │   │   └── NetworkManager.swift
│   │   ├── New Group
│   │   ├── SceneDelegate.swift
│   │   └── Views
│   │       ├── BubbleView.swift
│   │       ├── ChatCollectionViewCell.swift
│   │       ├── ChatContentConfiguration.swift
│   │       ├── ChatContentView.swift
│   │       └── DotsView.swift
│   └── ChatBot.xcodeproj
│       ├── project.pbxproj
│       ├── project.xcworkspace
│       ├── xcshareddata
│       └── xcuserdata
└── README.md
```

<br/>

## 🌟 핵심 구현사항

### STEP1
- API 서버와 통신하기 위한 데이터 모델 구현
- [OpenAI API reference](https://platform.openai.com/docs/api-reference/chat) 문서의 데이터 형식을 고려하여 모델 타입을 구현

### STEP2
- async/await와 URL Session을 활용한 서버와의 통신

### STEP3
- Modern Collection View 활용
    - CollectionView의 Configure + Diffable DataSource 사용하여 구현
- Core Graphics와 Core Animation의 활용 (말풍선 및 로딩중 말풍선)
- 대화를 누르거나, 스크롤 할 때 키보드가 내려가는 기능 구현 
    - KeyboardLayoutGuide를 활용


<br/>

## 🚀 트러블 슈팅

#### 1. 컬렉션뷰 셀의 재사용시 발생하는 말풍선 UI가 깨지는 현상
  
  - **문제 화면**
     - <a href="https://github.com/Dongjun-developer"><img src="https://hackmd.io/_uploads/r1XeTyb9p.png" width="300" height="700"></a>

  - **문제 이유**
    - 컬렉션 뷰가 재사용하면서 제대로 그리지 못함.

  - **문제 해결**
    - 셀이 재사용 될 때마다(-> didSet으로 구현) 말풍선을 다시 그려주도록 `setNeedsDisplay()`를 호출하여 해결함. 

    ```swift 
    // 문제 해결 코드
    final class BubbleView: UIView {
        var sender: Sender? {
            didSet {
                setNeedsDisplay()
            }
        }

        override func draw(_ rect: CGRect) {
            switch sender {
            case .assistant:
                makeAssistantBubble()
            case .user:
                makeUserBubble()
            case .loading:
                makeLoadingBubble()
            case .none:
                return
            }		
        }
    ...
    }
    ```

<br>

#### 2. cell의 constraint의 잘못 설정으로 Warning 발생

  - **Warning 로그**
    ```
    Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
    The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful.
    2024-01-17 20:28:21.021208+0900 ChatBot[41812:799325] [LayoutConstraints] Unable to simultaneously satisfy constraints.
        Probably at least one of the constraints in the following list is one you don't want. 
        Try this: 
            (1) look at each constraint and try to figure out which you don't expect; 
            (2) find the code that added the unwanted constraint or constraints and fix it. 
    (
        "<NSLayoutConstraint:0x6000019cf520 ChatBot.BubbleView:0x14f6409f0.trailing == ChatBot.ChatContentView:0x14f640330.trailing   (active)>",
        "<NSLayoutConstraint:0x600001986df0 H:|-(0)-[ChatBot.BubbleView:0x14f6409f0]   (active, names: '|':ChatBot.ChatContentView:0x14f640330 )>",
        "<NSLayoutConstraint:0x6000019cb070 ChatBot.BubbleView:0x14f6409f0.width <= 300   (active)>",
        "<NSLayoutConstraint:0x600001986d00 'fittingSizeHTarget' ChatBot.ChatContentView:0x14f640330.width == 361   (active)>"
    )

    Will attempt to recover by breaking constraint 
    <NSLayoutConstraint:0x6000019cb070 ChatBot.BubbleView:0x14f6409f0.width <= 300   (active)>

    Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
    The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful.
    ```

  - **문제 이유**
    - BubbleView의 제약조건과 BubbleView안의 TextLabel의 제약조건이 서로 충돌함.

  - **문제 해결**
    - bubbleView의 제약조건의 우선순위를 낮춰 충돌하지 않도록 해결함.

    ``` swift 
    // 문제 해결 코드
    final class ChatContentView: UIView, UIContentView {
        private func setConstraints() {
            userConstraints.forEach { constraint in
                constraint.priority = .defaultLow
            }
            assistantConstraints.forEach { constraint in
                constraint.priority = .defaultLow
            }
            loadingConstraints.forEach { constraint in
                constraint.priority = .defaultLow
            }
        }

        ...
    }
    ```
