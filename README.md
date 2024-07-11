# WarmBoysApp(따뜻한 청년들)
이 레파지토리는 앱 개발 설정에 필요한 내용들을 담고 있습니다.
1. 주의사항
2. 초기설정
<br/>


## 1. 주의사항
- git clone 후, WarmBoysApp 디렉토리 내에서 'flutter pub get' 명령어를 실행하시길 바랍니다.
- dev branch(개발 브랜치)는 main branch(메인 브랜치)에서 분기한 브랜치입니다.
- dev branch는 WarmboysApp 디렉토리와 본 설명 파일을 제외한 다른 디렉토리나 파일을 포함하지 않습니다. 따라서 main branch와 합칠 때, 이 점을 주의하길 바랍니다.
<br/>


## 2. 개발 환경
### 2.1 버전 및 운영체제
- pc: macos_arm64
- xcode: 15.0
- visual studio scode: 1.88.1
- flutter: 3.22.2
- dart sdk: 3.4.3
- cocoapods: 1.15.2
### 2.2 Cocoapods 설치 방법(m1 mac 대상)
```
# 1. ruby 설치
sudo arch -x86_64 gem install ffi
# 2. cocoapods 설치
sudo gem install cocoapods
# 3. cocoapods 버전 확인
3. pod --version
```
### 2.3 flutter 프로젝트 실행
```
# 1. flutter pub get 실행
cd WarmBoysApp
flutter pub get
# 2. flutter 설치 확인
flutter doctor
# 3. ios simulator 실행 후, flutter 프로젝트 실행
flutter run
```
<br/>
