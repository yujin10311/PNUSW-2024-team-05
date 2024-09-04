### 1. 프로젝트 소개
#### 1.1. 개발배경 및 필요성
이 프로젝트는 창의융합 해커톤에 참여하는 사람들에게 README 작성의 가이드라인을 제공하기 위해 제작되었습니다.
<br/>

#### 1.2. 개발목표 및 주요내용
창의융합 해커톤을 참여하는 사람들의 README 작성방법 이해을 돕는 것입니다.
<br/>

#### 1.3. 세부내용
가이드라인은 README에 들어가야 할 목차와 대략적인 내용을 설명합니다.
<br/>

#### 1.4. 기존 서비스(상품) 대비 차별성
> 작성하세요.
<br/>

#### 1.5. 사회적가지 도입 계획
> 작성하세요.
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
![image](https://github.com/user-attachments/assets/e9798fb2-2359-405c-ac31-fc3fd53d5fc3)
![image](https://github.com/user-attachments/assets/5848f2bc-804b-482a-9598-c1ec738713ff)
![image](https://github.com/user-attachments/assets/01aae17d-3a0a-4813-8174-8181e07bbb16)
<br/>

#### 3.2. 기능설명
##### ` 메인 페이지 `
- 상단 배너
  - 3초에 마다 자동으로 내용이 넘어갑니다. <br/>
    ![상단 배너](https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/4640389f-dcaf-4b78-916e-188c8e9c6ee7)

- 공지사항
  - 최근 5개의 공지사항을 보여줍니다.
  - 발행된지 일주일이 안 된 공지사항은 new라는 mark표시를 해줍니다.
  - 공지사항 글을 클릭하면 해당 공지사항 게시글로 이동합니다.
  - 상단의 더보기 버튼을 클릭하면 공지사항 페이지로 이동합니다.<br/>
    <img width="600px" alt="공지사항" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/7c425946-ff06-4b32-8b18-4119cc86e308">

- 이번 주 보너스 문제
  - 이번 주의 보너스 점수를 주는 문제를 보여줍니다.
  - 문제를 클릭하면, 해당 문제의 게시글로 이동합니다. <br/>
    <img width="600px" alt="이번 주 보너스 문제" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/5c603984-8cf6-4524-84a6-5410bb6a8cbf">

- 실시간 랭킹
  - 상위 랭킹 10명의 유저를 보여줍니다.
  - 상단의 더보기 버튼을 클릭하면 전체 랭킹 페이지로 이동합니다.<br/>
    <img width="200px" alt="실시간 랭킹" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/8492e285-5423-4c00-bc46-400cbe733d35">
<br/>

##### ` 문제 페이지 `
- 문제 목록
  - 사용자가 설정한 한 번에 보여줄 문제 갯수 만큼 한 화면에 문제를 띄워줍니다.
  - 검색창에서 문제의 제목 및 번호로 문제를 검색할 수 있습니다.
  - 난이도, 영역, 카테고리 별로 문제를 볼 수 있습니다.
  - 상단의 shuffle 이모지를 클릭하면 랜덤으로 선택된 문제 푸는 페이지로 이동합니다.
  - 목록에서 문제를 클릭하면 해당 문제를 푸는 페이지로 이동합니다.
    ![문제 목록](https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/95afd0db-b5a7-4628-ac9c-164513a9e51b)
<br/>


#### 3.3. 기능명세서
<img width="200px" alt="실시간 랭킹" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/97ad3fea-f90a-437a-b611-3fb8cd24070e" />

|라벨|이름|상세|
|:---:|:----------------------------:|:---|
| S1  | 부산대학교 웹메일              | - 부산대 웹메일 형식인지 검증 <br/>- 중복되는 이메일인지 검증 |
| S2  | 부산대학교 웹메일 인증 코드 전송| - 클릭 시 인증 코드 메일로 전송 |
| S3  | 메일 인증 코드                 | - 인증 요청 버튼 클릭 후 활성화 <br/>- 유효시간 5분|
| S4  | 메일 인증 코드 확인            | - 인증코드 검증 |
| S5  | 닉네임                        | - 4 ~ 12자 영어, 숫자, '_' 가능 |
| S6  | 단과대학 선택                  | -부산대학교 단과대학 리스트 보여주기 |
| S7  | 학과 선택                     | - 단과대학 안의 학과 리스트 보여주기 |
| S8  | 비밀번호                      | - 입력 시 텍스트 보이지 않도록 •로 표현해주기 <br/>- 6자 이상 20자 이하, 영어와 숫자 조합 필수 |
| S9  | 비밀번호 확인                  | - 입력 시 텍스트 보이지 않도록 •로 표현해주기 <br/>- 비밀번호와 동일한 지 검증 |
| S10 | 회원가입 완료                  | - 비어 있는 입력 칸이 없는지 검증 <br/>-메일 인증 완료했는지 확인 <br/>-조건을 만족하면 회원가입 성공|
| S11 | 로그인                        | - 클릭 시 로그인 모달로 전환 |

<br/>

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
- 위의 사용 기술 참고

```bash
$ git clone https://github.com/test/test.git
$ cd test/frontend
$ npm i
$ export NODE_ENV="development" # windows: set NODE_ENV=development
$ npm run build:dll
$ export TARGET="http://localhost:8000"  # windows: set NODE_ENV=http://localhost:8000
$ npm run dev
```
<br/>


### 5. 소개 및 시연영상
[<img width="700px" alt="소개 및 시연영상" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/162132cd-9af5-4154-9b9a-41c96cf5e8fd" />](https://www.youtube.com/watch?v=EfEgTrm5_u4)

<br/>

### 6. 팀 소개
| MEMBER1 | MEMBER2 | MEMBER3 |
|:-------:|:-------:|:-------:|
|<img width="100px" alt="MEMBER1" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/f5b5df2a-e174-437d-86b2-a5a23d9ee75d" /> | <img width="100px" alt="MEMBER2" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/fe4e8910-4565-4f3f-9bd1-f135e74cb39d" /> | <img width="100px" alt="MEMBER3" src="https://github.com/pnuswedu/SW-Hackathon-2024/assets/34933690/675d8471-19b9-4abc-bf8a-be426989b318" /> |
| member1@pusan.ac.kr | member2@gmail.com | member3@naver.com |
| 프론트앤드 개발 | 인프라 구축 <br/> 백앤드 개발 | DB 설계 <br/> 백앤드 개발 |


<br/>


### 7. 해커톤 참여 후기
- MEMBER1
  > 작성하세요.
- MEMBER2
  > 작성하세요.
- MEMBER3
  > 작성하세요.
<br/>
