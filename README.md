### 1. 프로젝트 소개
#### 1.1. 개발배경 및 필요성
### 1) 통계 

건강보험심사평가원 통계에 따르면, 2022년 국내 우울증 환자는 100만을 넘겼으며, 그 중 35.9%가 2030 젊은층입니다.
![image](https://github.com/user-attachments/assets/ff3fd96b-8606-4dc6-a41d-26756c7f9470)

### 2) 우울증 시대 상황

 많은 청년들은 주로 무기력과 불안, 불면 등의 증상을 호소하며 상담기관을 찾았습니다. 수많은 청년 우울증 환자를 만든 주된 원인은, 경쟁 사회 속 경제적 또는 사회적 자립에 대한 부담감 때문이죠. 과거에 비해 미래의 불확실성이 높아지고, 소셜미디어의 발달로 다른 사람과 스스로를 비교하거나 비교를 당하는 경우가 많아졌죠. 하지만 현실적으로 선택할 수 있는 폭은 굉장히 좁은 상황에서 자연스레 청년의 불안이 증가했다는 점은 청년이라면 공감할 수 있다고 생각합니다. 뿐만 아니라 코로나 19를 계기로 사회적 고립감이 커지며, 청년 우울증 문제가 더 깊어지게 되었습니다.


 ### 3) 우울증 해결 방안과 그 관리 실태 - 개발 필요성
우울증의 시작은 일시적인 우울 증상을 뜻하는 ‘우울감’의 지속으로부터 비롯되는데, 초기의 우울감을 빠르게 파악하고 관리한다면 충분히 우울증을 예방할 수 있습니다. 실제로 정신의학과 전문의의 인터뷰에 따르면, 2주 이상 상실 및 공허함, 외로움, 감정기복의 지속을 느꼈을 때 즉시 상담과 치료를 받으면 우울을 회복할 수 있다고 합니다. 그러나, 우울감의 관리가 결코 쉽지 않은 것이 또 하나의 문제점입니다. 현대의 청년들은 스스로 감정을 파악하고 느끼는 일에 낯설어 합니다. 한 인터뷰에 따르면, 24살 대학 A씨는 스트레스를 받는다는 게 무엇인지, 어떻게 풀어야 하는지 몰랐다며, 신체적으로반응이 오고 나서야 자신이 스트레스를 받았음을 깨달았다고 응답한 바가 있습니다. 부산대 내 상담센터인 효원상담원을 이용한 대학생 3명을 대상으로 FGI(표적 집단 면접)을 자체적으로 진행한 결과, ‘상담을 하기 전까지 제가 우울증 위험군인 줄 몰랐어요.’, ‘평소에 감정이나 우울에 대해 잘 생각해보지 않아요.’ 라는 의견을 도출할 수 있었습니다. 정리하자면, 우리 사회는 우울증의 예방 해결책이 되는 ‘우울감, 감정 관리’가 원활히 되지 못하고 있습니다.


### 4) '인사이드 아웃' 팀이 주목한 핵심 문제
 우리 ‘인사이드 아웃’ 팀은 잘 보이지 않아 관리할 수 없는 ‘우울감’의 시각화를 솔루션으로 떠올렸습니다. 우울증 환자의 발생을 예방하기 위해, 청년 스스로 자신의 감정을 파악하고 개선하도록 유도하고, 그 과정에서 번거로움과 낯섦 없도록 수동형 AI 챗봇 기술을 활용하고자 합니다.

#### 1.2. 개발목표 및 주요내용

### 1) 개발목표
청년 우울감 해소를 최종 목표로 한 지속적인 감정 관리 어플

### 2) 주요내용(기능)
#### ● 기록 – 감정형 ai 챗봇 및 자연어처리를 통한 일기화
우울증 극복의 첫 단계는 자신의 감정을 파악하고 이해하는 것입니다. 그러나 많은 청년들이 감정에 대
해 글을 쓰는 행위에 익숙하지 않다는 점을 고려해, 챗봇 기술을 도입하였습니다. 사용자가 부담없이 챗봇에
게 메시지를 보내 대화를 시작하고, 챗봇은 사용자에 공감적 태도로 반응하며 대화를 지속한다. 챗봇과
사용자 간의 문답 형식의 대화를 통해, 글쓰기의 부담을 줄이고 자연스럽게 자신의 감정을 표현할 수 있
다. 대화 내용은 자연어처리 기술을 통해 요약 분석되어, 앱 내 캘린더에 도출된 매일의 감정과 대화 내
용 기반으로 재구성된 일기를 확인할 수 있다.
#### ● 보상 - 지속적인 대화에 따른 아바타
미래에 대한 기대감을 느끼지 못하게 만드는 우울감의 특성상 달성 가능한 목표를 세우고 이를 달성했
을 때 보상을 받는 것은 우울 극복에 중요하다. 이를 위해 우리는 ‘보상하기’ 를 구현하는 기능을 고안하
였다. 사용자가 챗봇과 대화를 한 후 도출되는 감정 상태에 따라 아바타가 도출된다. 이 아바타 캐릭터
는 생성형 AI로 도출된 이미지로서, 개별 사용자마다 다른 이미지로 차별화 가능하다.
#### ● 소통 - 사용자 간 숏폼 커뮤니티
주변 사람에게 자신의 상태를 알리는 행위를 통해 우울감을 극복할 수 있다는 점을 고려해, 소통 기능
을 핵심 요소로 추가했다. 특히나 비슷한 상황에 처한 사람 간의 소통을 이끌되 부정적인 반응과 소통이
유도되지 않도록 사용자 간의 커뮤니티 서비스를 설계했다. 사용자는 챗봇과의 대화를 바탕으로 도출된
일기를 공유하거나 직접 글을 작성해 앱 내 커뮤니티에 글을 작성할 수 있다. 게시글은 ‘숏폼’ 형식, 즉
특정 콘텐츠를 검색하지 않고 랜덤한 게시글을 접하며 타 사용자와 소통할 수 있고, 긍정적인 반응을 남
겨 상호작용할 수 있다.
#### ● 추가 자가진단 유도 기능 - PHQ-9 우울 자가진단 척도
2주마다 한번씩 사용자에게 챗봇을 이용해 자가진단을 유도함으로써, 우울증 진단의전문성을
확보하였고 우울증 위험군의 사용자를 파악하여 전문가와의 치료를 권유하고자 한다. 이와 같은
기능을 통해 우리의 앱은 사용자가 감정을 기록하고, 작은 성취를 통해 보상을 받으며, 타인과
의 소통을 통해 우울증을 극복하는 데 도움을 줄 것이다. 이러한 기능들은 우울감을 느끼는 사
용자에게 유의미한 회복 요인으로 작용할 수 있으며, 지속적인 사용을 유도한다. 추가적으로 이
런 사용자 채팅에 따른 우울감 척도, 기분 척도의 변화 데이터가 충분하게 수집된다면, 해당 데
이터와 자연어 처리 AI기술을 접목하여 채팅만으로 사용자의 우울증 척도를 예측할 수 있는 모
델을 개발하는 등 여러 심리상담센터와 연구소와의 협업 가능성도 열어둘 수 있게 될 것이다.


### 1) 챗봇 기능

#### 가) 채팅
|채팅|
|-|
|하단 버튼을 통해 PHQ-9 설문조사 화면으로 이동|
|사용자는 채팅창의 숫자 입력을 통해 설문조사에 점수를 메길 수 있음|
|설문조사가 끝나면 설문내용 및 사용자의 점수와 진단 결과를 데이터 베이스에 저장한다.|

#### 나) 설문조사(PHQ-9)
|설문조사(PHQ-9)|
|-|
|사용자는 채팅창의 숫자 입력을 통해 설문조사에 점수를 매김|
|설문조사가 끝나면 설문내용 및 사용자의 점수와 진단 결과를 데이터 베이스에 저장한다. 설문조사의 보상으로 credit을 추가|
|채팅 박스를 클릭하면 사용자가 텍스트를 입력 가능|
|전송 버튼을 누르면 입력한 텍스트가 챗봇 모델에게 input|
|사용자가 input 한 텍스트와 그에 대응되는 챗봇 모델의 output 텍스트를 한 화면상에 보임|
|하루의 대화가 종료되면, 모든 대화 내역을 날짜와 함께 데이터 베이스에 저장한다. 대화의 보상으로 credit도 추가|

### 2) 캘린더 기능

#### 가) 달력 연도, 월 탐색
|달력 연도, 월 탐색|
|-|
|캘린더 윗부분 연도와 월이 표시된 칸을 누르면 이를 선택하는 창이 나타냄|
|선택한 연도, 월, 사용자 정보를 기반으로 사용자 대화 요약 데이터베이스에서 해당 연도, 월의 기분 요약 데이터를 가져온 옴|
|달력에 일별 기분과 매칭되는 labeled image를 배치하여 간단히 표시|
|캘린더에서 특정 날짜 선택 -> 대화 데이터베이스에서 해당 날짜의 대화 요약, 기분 데이터, 세부 대화 내역을 가져 옴 -> 새로운 페이지를 열어 이를 표시|
|공유 버튼을 누르면 해당 대화 내용은 공유된 서버로 보내지고, 다른 사용자들도 이를 확인할 수 있는 상태가 됨|
#### 나) 통계
|통계|
|-|
|캘린더 메뉴 아래부분에서 검색한 연도 기준 월별 우울감 척도 변화 사항을 확인할 수 있음|
|캘린더 메뉴 아래부분에서 검색한 월별 기준 총 기분 합계를 확인해볼 수 있음|
### 3) 커뮤니티 기능
#### 가) 커뮤니티
|커뮤니티|
|-|
|커뮤니티탭에 들어오거나 커뮤니티를 위 또는 아래로 스와이프하면 서버에 새로운 커뮤니티를 요청|
|공감 버튼을 누르면 해당 커뮤니티의 이모티콘의 count를 늘리도록 서버에 요청해 데이터베이스에서 업데이트|
|신고 버튼을 누르면 신고 내용을 선택하는 팝업창을 띄우고 사유를 골라 커뮤니티 정보와 신고 내용을 서버 전송|
|검색창에 해시태그를 입력 후 서버에 해당 해시태그 가진 커뮤니티 목록 요청|
|해시태그를 누르면 검색창에 해시태그를 입력한 것과 동일하게 동작|
|내 커뮤니티 버튼을 누르면 사용자의 ID를 가진 커뮤니티 목록을 서버에 요청|
|커뮤니티 만들기 버튼 클릭 -> 작성 후 만들기 버튼 -> 제목, 내용, 해시태그 등 정보를 서버에 보내기 -> 데이터베이스 저장|

### 4) 설정 및 사용자 관리 기능

#### 가) 회원가입
|회원가입|
|-|
|회원가입 시 ID, Password, 나이, 성별, 닉네임을 입력받아 데이터베이스에 저장|
#### 나) 로그인
|로그인|
|-|
|ID와 Password를 서버로 보내 로그인|
#### 다) 설정
|설정|
|-|
|홈화면에 설정 아이콘을 눌러 설정탭으로 이동|
|설정탭에서 로그아웃, 회원정보, 진단통계, 통계자료 공유 기능|
|로그아웃을 누르면 현재 사용하는 회원정보를 이용하지 않음|
|회원정보를 누르면 데이터베이스에 저장되어 있는 회원정보를 봄|
|진단통계를 누르면 2주 간격으로 데이터베이스에 저장된 진단결과를 봄|
|통계자료 공유를 누르면 pdf 또는 이미지 형태로 진단결과를 외부로 공유|
#### 1.3. 세부내용

### 1) 챗봇 기능
#### 가) 채팅
|채팅|
|-|
|채팅 박스를 클릭하면 텍스트를 입력 가능|
|전송 버튼을 누름으로써 입력한 텍스트를 챗봇 모델에게 전달|
|chatbot과의 대화를 화면상으로 볼 수 있음|

#### 나) 설문조사
|설문조사|
|-|
|2주간격으로, 대화를 통해 PHQ-9 설문조사를 안내 받음|
|채팅 화면에 나타나는 질문에 사용자가 생각하는 점수를 전송함|

### 2) 캘린더 기능
#### 가) 달력 연도, 월 탐색 및 통계
|달력 연도, 월 탐색 및 통계|
|-|
|캘린더 메뉴에서 선택한 연도, 월을 기준으로 전체적인 기분 변화와 우울증 척도 변화를 확인 가능|
|캘린더 메뉴에서 선택한 연도, 월, 일을 기준으로 지난 기분과 지난 대화 데이터 요약을 확인 가능|
|캘린더 메뉴에서 선택한 연도, 월, 일을 기준으로 지난 세부 대화 데이터 내용을 확인 가능|
|했던 대화 내역을 다른 사용자들과 공유 가능|

### 3) 커뮤니티 기능
#### 가) 커뮤니티
|커뮤니티|
|-|
|커뮤니티탭에서 위 또는 아래로 스와이프하여 다음 커뮤니티를 확인 가능|
|커뮤니티에 공감 버튼을 눌러 반응을 남길 수 있음|
|부적절한 커뮤니티는 신고 버튼으로 신고 가능|
|검색창에 해시태그를 입력해 해당 해시태그를 가진 커뮤니티를 찾을 수 있음|
|커뮤니티의 해시태그를 눌러 자동으로 검색창에 해시태그를 검색한다|
|사용자가 작성한 커뮤니티를 한번에 모아서 확인 가능|
|제목, 내용, 해시태그로 구성된 커뮤니티를 작성 가능|)
### 4) 설정 및 사용자 관리 기능
#### 가) 회원가입
|회원가입|
|-|
|사용자가 앱을 처음 사용할 때 회원가입 가능|
|시작화면에서서 회원가입 버튼을 누르면 회원가입 창으로 이동|
|회원가입 시 ID, Password, 나이, 성별, 닉네임 입력|

#### 나) 로그인
|로그인|
|-|
|시작화면에서 ID와 Password를 통해 로그인|
#### 다) 설정
|설정|
|-|
|홈화면에서 설정탭으로 이동|
|설정탭에서 로그아웃, 회원정보, 진단통계, 통계자료 공유|

#### 1.4. 기존 서비스(상품) 대비 차별성

‘우울증 해소’를 목표로 한 앱 서비스는 기존에 존재하고 있지만, 우울증 이전의 ‘우울감’에 집중한 솔루
션으로서의 서비스는 존재하지 않는다는 점에서 차별성이 발생한다. ‘마인드’, ‘마보’ 등 기존 서비스는 우
울증 개선만을 목표로 하여 의학적으로 접근하고 있기에 높은 유저 진입장벽이 한계로 작용한다.
또한 기존 서비스는 기능 상 통합성을 확보하지 못하고 있다. ‘감쓰’ 서비스는 기록 기능을 확보하고 있
지만 앱 사용 지속성과 연관된 ‘보상 기능’이 부족하며, ‘Cognifit’ 서비스는 우울증을 비롯한 우울감 개선
을 미니게임이라는 요소를 연관시켰지만 기록과 소통 측면에서의 아쉬움이 존재한다.
이를 고려했을 때, 기록, 보상, 소통 그리고 의학 척도를 이용한 자가진단 기능까지 확보한 ‘인사이드아웃’
서비스는 기존 서비스가 가지지 못한 통합성을 갖춘, 효과적인 우울감 개선 서비스라는 점에서 차별성을 확
보한다.
|기존 서비스|구성 요소|특징|문제점|보완점|
|-|-|-|-|-|
|CogniFit|우울증 평가 미니게임 보상 시스템|게임을 활용해 지속적인 앱 활용 유도|미니게임 플레이와 우울증 개선 간 낮은 연관성|기능과 우울개선 간 연관성 보완|
|감쓰|감정 기록, 기록물 통계 시각화|감정 청소라는 시각적 효과 적용|기능의 단편성 (기록뿐)|통합 기능 추가, 지속적 활용을 위한 요소 추가|
|마인드|스트레스, 불면, 우울증 개선|뇌과학 전문가로 전문성 확보|낮은 앱 활용 지속성|지속적 활용을 위한 요소 추가|
|마보|정신 개선 훈련|사용자 간 댓글 풍부한 콘텐츠|긍정적 측면만 전달(일방적 내용)|지속적 활용을 위한 요소 추가, 내용 상 보강|
<br/>

#### 1.5. 사회적가지 도입 계획
### - 사회적 측면
○ 지역 및 대학 상담 센터 연계: 지역 보건소, 정신 건강 센터, 대학교 상담 센터와 협력하여 앱을 제공
함으로써 사용자가 자신의 감정을 기록하고 이를 센터의 전문가와 공유할 수 있다. 보다 개인화된 상담
과 정기적인 감정 기록을 통한 효과적인 상담을 받을 수 있다.
○ 커뮤니티 프로그램 및 캠페인: 지역사회와 대학교에서 정기적인 워크숍, 세미나, 정신 건강 캠페인을
통해 앱 사용을 촉진하고 앱 내 정신건강 관리를 유도할 수 있다.

### - 사업화 계획
○ 챗봇 고도화
PHQ-9 조사 없이도 전문성 있는 우울감 분석이 가능하도록 챗봇을 업그레이드할 예정이다. 이를 통해
더 정확하고 신뢰할 수 있는 감정 분석 서비스를 제공할 수 있다.
○ B2B 모델 구축
지역사회 및 대학교와의 협력을 통해 B2B 모델을 구축한다. 보건소, 정신 건강 센터, 대학교 상담 센터
등에 앱 서비스 또는 감정 데이터를 제공하고 정기적인 사용료를 받는 방식으로 수익을 창출한다.
○ 프리미엄 서비스 제공
기본 기능은 무료로 제공하고, 추가적인 프리미엄 서비스(예: 전문가와의 1:1 상담, 맞춤형 감정 분석 리
포트 등)를 유료로 제공한다. 보다 깊고 다양한 사용자의 요구를 충족시키고 추가 수익을 창출할 수 있
다.
○ 사용자 데이터 활용 및 서비스 고도화
사용자 입지를 다진 후 다량의 사용자 데이터를 확보하여, 누적 데이터를 이용한 새로운 시도 방안을 확
립할 것이다. 이를 통해 서비스를 고도화하고, 개인 맞춤형 챗봇과 소통 채널을 더욱 발전시킬 것이다.

<br/>


### 2.상세설계
#### 2.1. 시스템 구성도
![image](https://github.com/user-attachments/assets/3f817443-2fac-411d-af2f-99c717e19ecb)

<br/>


#### 2.3. 사용기술
| 이름                  | 버전    |
|:---------------------:|:-------:|
| Python                | 3.8.0   |
| Django                | 3.2.9   |
| Django Rest Framework | 3.12.0  |
| Node.js               | 16.16.0 |
| Vue.js                | 2.5.13  |
<br/>


### 3. 개발결과
[코딩역량강화플랫폼 Online Judge](http://10.125.121.115:8080/)를 예시로 작성하였습니다.
#### 3.1. 전체시스템 흐름도
![image](https://github.com/user-attachments/assets/20d55204-23f1-4df5-b956-b2577f74eddc)
<br/>

#### 3.2. 기능설명
##### ` 메인 페이지 `
- 로그인 페이지

  - 회원가입과 로그인이 가능합니다.

  <img width="200px" src = https://github.com/user-attachments/assets/9e7be31b-4111-4b85-92f3-78dbadcca172 />
  <img width="200px" src = https://github.com/user-attachments/assets/502ad38d-6e19-4998-9d33-489d0ded549a />

- 메인 페이지

  - 달력으로 해당 날짜의 우울 평가 점수와 채팅 기반 감정 상태 분석 결과를 확인할 수 있습니다. 

  <img width="200px" src = https://github.com/user-attachments/assets/756eb58a-bacd-4d52-876f-7d4f557b556c />

  - 일기 버튼을 누르면 그날 채팅 데이터 기반 일기 내용을 확인할 수 있습니다.

  <img width="200px" src = https://github.com/user-attachments/assets/4a17565d-3543-4cb5-b004-50cc0536e7fe />
  
- 채팅 페이지

  - 챗봇과 채팅을 할 수 있는 화면입니다.

  <img width="200px" src = https://github.com/user-attachments/assets/61ea1c7a-0a88-4544-b5d2-ac04d2e89f33 />


- 커뮤니티 페이지
  - 다른 사용자들이 올린 게시글 내용을 확인할 수 있습니다. 공감 버튼으로 게시글에 대한 공감 표시도 할 수 있습니다.

  <img width="200px" src = https://github.com/user-attachments/assets/1c7a8b6a-b5b1-4018-b06c-614e636351dd />

  - 글쓰기 버튼을 누르면 게시글을 직접 작성할 수 있습니다.

  <img width="200px" src = https://github.com/user-attachments/assets/b7788beb-e9e4-45f3-ba8a-091e4a88d92f />

- 검사 페이지
  - 본인의 우울척도 검사를 시행할 수 있습니다.

  <img width="200px" src = https://github.com/user-attachments/assets/5afc8ad4-a0b2-4099-8557-49ec357c08ac />

  - 우울척도 검사 결과를 확인할 수 있습니다.

  <img width="200px" src = https://github.com/user-attachments/assets/cfe8a1dc-6af8-4885-b4d4-b194110703c1 />



#### 3.3. 기능명세서



#### 3.4. 디렉토리 구조
```
├── backend/                                                        # 백엔드 코드와 서버관련 파일이 위치한 디렉토리
│   ├── main.py                                                     # 백엔드의 주요 로직이 구현된 Python 스크립트
├── chat2/                                                          # Android 애플리케이션의 메인 프로젝트 디렉토리
│   ├── app/                                                        # Android 앱 소스 코드가 포함된 디렉토리
│   │   ├── src/                                                    # 프로젝트의 소스 코드가 위치한 디렉토리
│   │   │   ├── main/                                               # 애플리케이션의 메인 소스 디렉토리
│   │   │   │   ├── java/com/example/chat2/                         # Kotlin 코드가 위치한 패키지 디렉토리
│   │   │   │   │   ├── AvatarActivity.kt                           # 아바타 화면
│   │   │   │   │   ├── ChatActivity.kt                             # 채팅 화면
│   │   │   │   │   ├── CheckActivity.kt                            # (쓰이지 않음)
│   │   │   │   │   ├── CommunityActivity.kt                        # 커뮤니티 화면
│   │   │   │   │   ├── CommunityAdapter.kt                         # (쓰이지 않음)
│   │   │   │   │   ├── CommunityWriteActivity.kt                   # 커뮤니티 글(쇼츠) 쓰기 화면
│   │   │   │   │   ├── ContentModel.kt                             # 컨텐츠 클래스 정의
│   │   │   │   │   ├── DiaryActivity.kt                            # 일기 화면
│   │   │   │   │   ├── HomeActivity.kt                             # 홈 화면
│   │   │   │   │   ├── LogInActivity.kt                            # 로그인 화면
│   │   │   │   │   ├── MainActivity.kt                             # (쓰이지 않음)
│   │   │   │   │   ├── Message.kt                                  # 
│   │   │   │   │   ├── MessageAdapter.kt                           # 
│   │   │   │   │   ├── Question.kt                                 # 설문조사 관련 변수 선언 파일
│   │   │   │   │   ├── QuestionData.kt                             # 설문조사 내용이 저장된 파일
│   │   │   │   │   ├── ResultActivity.kt                           # 설문조사 결과 화면
│   │   │   │   │   ├── Score.kt                                    # 설문조사 점수 관련 번수 선언 파일
│   │   │   │   │   ├── SignUpActivity.kt                           # 회원가입 화면
│   │   │   │   │   ├── SurveyActivity.kt                           # 설문조사 화면
│   │   │   │   │   ├── User.kt                                     #
│   │   │   │   │   ├── UserAdapter.kt                              #
│   │   │   │   ├── res/                                            # 애플리케이션 리소스 파일이 포함된 디렉토리
│   │   │   │   │   ├── drawble/                                    # 이미지 및 XML 그래픽 리소스가 저장된 디렉토
│   │   │   │   │   │   ├── avatar.jpg                              # 아바타 이미지 파일
│   │   │   │   │   │   ├── avatar_btn_background.xml               # 채팅 버튼 배경을 정의한 XML 파일
│   │   │   │   │   │   ├── btn_background.xml                      # 일반 버튼 배경을 정의한 XML 파일
│   │   │   │   │   │   ├── chat.png                                # 로그인 화면의 이미지 파일 (쓰이지 않음)
│   │   │   │   │   │   ├── chat_btn_background.xml                 # 채팅 버튼 배경을 정의한 XML 파일
│   │   │   │   │   │   ├── comunity_btn_background.xml             # 커뮤니티 버튼 배경을 정의한 XML 파일
│   │   │   │   │   │   ├── edit_background.xml                     # 회원가입 화면 버튼 배경을 정의한 XML 파일
│   │   │   │   │   │   ├── ic_launcher_background.xml              # 애플리케이션 런쳐 배경을 정의한 XML 파일
│   │   │   │   │   │   ├── ic_launcher_foreground.xml              # 애플리케이션 런처 전경을 정의한 XML 파
│   │   │   │   │   │   ├── insideout.png                           # insideout 로고 이미지 파일
│   │   │   │   │   │   ├── logo.png                                # insideout 로고 이미지 파일
│   │   │   │   │   │   ├── option_background.xml                   # 옵션 배경을 정의한 XML 파일
│   │   │   │   │   │   ├── selected_option_background.xml          # 선택된 옵션 배경을 정의한 XML 파일
│   │   │   │   │   ├── layout/                                     # UI 레이아웃 XML 파일이 저장된 디렉토리
│   │   │   │   │   │   ├── activity_avatar.xml                     # 아바타 화면의 XML 파일
│   │   │   │   │   │   ├── activity_chat.xml                       # 채팅 화면의 XML 파일
│   │   │   │   │   │   ├── activity_check.xml                      # (쓰이지 않음)
│   │   │   │   │   │   ├── activity_community.xml                  # 커뮤니티 화면의 XML 파일
│   │   │   │   │   │   ├── activity_diary.xml                      # 일기 화면의 XML 파일
│   │   │   │   │   │   ├── activity_home.xml                       # 홈 화면의 XML 파일
│   │   │   │   │   │   ├── activity_log_in.xml                     # 로그인 화면의 XML 파일
│   │   │   │   │   │   ├── activity_main.xml                       # 메인 화면의 XML 파일 (쓰이지 않음)
│   │   │   │   │   │   ├── activity_result.xml                     # 설문조사 결과 화면의 XML 파일
│   │   │   │   │   │   ├── activity_sign_up.xml                    # 회원가입 화면의 XML 파일
│   │   │   │   │   │   ├── activity_survey.xml                     # 설문조사 화면의 XML 파일
│   │   │   │   │   │   ├── activity_writecommunnity.xml            # 커뮤니티 글 쓰기 화면의 XML 파일
│   │   │   │   │   │   ├── receive.xml                             # 받는 메세지의 XML 파일
│   │   │   │   │   │   ├── send.xml                                # 보내는 메세지의 XML 파일
│   │   │   │   │   │   ├── user_layout.xml                         # 사용자 화면의 XML 파일 (쓰이지 않음)
│   │   │   │   │   ├── menu/                                       # (쓰이지 않음)
│   │   │   │   │   │   ├── menu.xml                                # (쓰이지 않음)
│   │   │   │   │   ├── values/                                     # 다양한 XML 값이 정의된 디렉토리
│   │   │   │   │   │   ├── colors.xml                              # 애플리케이션에서 사용되는 색상 정의 파일
│   │   │   │   │   │   ├── strings.xml                             # 애플리케이션에서 사용되는 문자열 정의 파일
│   │   │   │   │   │   ├── themes.xml                              # 애플리케이션 테마 정의 파일
│   │   │   ├── build.gradle.kts                                    # 모듈에 대한 Gradle 설정 파일
│   │   │   ├── google-services.json                                # Firebase 설정 파일
│   │   │   ├── build.gradle.kts                                    # 전체 프로젝트에 대한
 Gradle 설정 파일
```
<br/>


### 4. 설치 및 사용 방법
**필요 패키지**
```bash
$ git clone https://github.com/Inside-Out-Pusan-univ/Inside-Out
```
- andriod studio를 사용해 접근하여 app 파일로 이동.
- sync project with gradle files 버튼을 누른뒤
- local.properties 파일에서 본인의 gemini api-key를 입력한 뒤에 실행



### 5. 소개 및 시연영상
[<img width="700px" alt="소개 및 시연영상" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/162132cd-9af5-4154-9b9a-41c96cf5e8fd" />](https://www.youtube.com/watch?v=EfEgTrm5_u4)

<br/>

### 6. 팀 소개

‘인사이드아웃’ 팀은 기획 인력 2명, 개발 인력 4명으로 구성되어 있습니다.
개발팀은 전원 의생명융합공학부 데이터사이언스 20학번 전공생으로 이루어져 있으며, 백엔드 개발자
인 하석현 팀원과 백원재 팀원, 프론트엔드 개발자인 김도형 팀원과 김예준 팀원으로 구성되어 있습니
다.

개발팀은 전공 역량을 충분히 갖추고 있을 뿐만 아니라, 공모전 출품을 통해 개발 역량을 쌓아온 실력
자입니다. 컴퓨팅 자원낭비 해소 웹 도구를 개발해 2024 경희대 Khuthon 최우수상을 수상했으며, 국
립재활원 보조기기 해커톤에서 우수상을 수상했습니다. 카카오 테크캠퍼스 2기에서 Android 트랙을
이수한 팀원 또한 있습니다.

기획팀은 경영학 전공 21학번 이유진, 산업공학 전공 21학번 김원형으로 구성되어 있습니다. 개발 인
력은 아니지만, 이전에 IOS, Android 서비스 앱 출시 후 실제 유저를 유치한 경험을 통해 확실한 니
즈의 앱 서비스를 기획하는 능력을 가지고 있습니다. 뿐만 아니라 영세기업 신제품 기획 협업을 통해
공모전 전략기획 부문에서 대상을 수상한 경험을 바탕으로, 실질적인 앱 서비스의 비즈니스 모델 수립
에 대한 역량을 보유하고 있습니다.



<br/>


### 7. 해커톤 참여 후기

- 하석현
  > 처음으로 우리 아이디어로 직접 어플을 만들어보는 경험은 앞으로의 개발자 경험에도 큰 도움울 줄 수 있을 것 같습니다. 아주 유익한 시간이었고, 앞으로도 더 좋은 개발자가 될 수 있도록 노력하겠습니다.
- 김원형
  > 난생 처음 만져보는 협업&디자인 툴 등 새로움에 익숙해지는 시간이었고, 경험을 축척하는 시간이었습니다.
- 김예준
  > 어플 개발을 직접하고 구현되는 과정이 바로바로 눈에 보여서 재미있었습니다. 단순 구현이 생각보다 시간이 많이 걸려서 더 많은 기능을 못 담은게 아쉽습니다.
<br/>

### 8. 참고문헌 및 출처


김경연, 정재희. (2023). 초기 우울증 대학생의 정신건강 앱 지속 사용 동기부여를 위한 디자인 제안-
정보-동기-행동기술 모델을 기반으로-. 한국디자인문화학회지, 29(4), 33-46,
10.18208/ksdc.2023.29.4.33
안순태, 이하나. (2021). 청년과 중년 세대의 우울감 표현 방식과 이유에 대한 탐색적 연구: 감정 표현
규범 인식의 영향력을 중심으로. 지역사회간호학회지, 32(1), 12-23.
성공회대 미디어센터, [청년, 우울을 만나다]
건강보험심사평가원, 국가정신건강현황보고서 (2021년)
pitzer RL., Kroenke K., Williams JBW. Validation and utility of a self-report version of
PRIME-MD: the PHQ prima
