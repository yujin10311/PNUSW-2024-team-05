
### 목차
1. 주의사항
2. 개발환경
3. 프로젝트 실행

</br>

### 1. 주의사항
- 개발이 최종 완료된 후, ‘dev’ 브랜치를 ‘main’ 브랜치에 합쳐야 한다.
- ‘dev’ 브랜치 디렉토리에는 ‘main’ 브랜치 디렉토리에서 빠진 파일들이 많기 때문에 나중에 병합할 때, ‘main’ 브랜치의 파일이 삭제되지 않도록 주의해야 한다.
- 아래 OS별 개발 환경을 자의적으로 변경해서는 안 된다.
- 개발 도중 새로운 라이브러리가 추가되거나 버전이 변경되는 경우, 이 문서에 반영하도록 한다.
- 개발 과정에서 참고해야하는 사항들을 자유롭게 추가할 수 있다.

</br>

### 2. 개발 환경
#### 2.1 버전
- flutter: 3.22.2 (stable)
- dart: 3.4.3(stable)
- ruby: 2.6.10p210
- cocoapods: 1.15.2(설치는 ‘2.2 프로젝트 실행’ 참조)

- vscode: 1.88.1
- xcode: 15.0(빌드 번호: 15A240d)

#### 2.2 라이브러리
> 작성바람

</br>


### 3. 프로젝트 실행

```
# 1. gem 설치(macos_arm64)
sudo arch -86_64 gem install ffi

# 2. cocoapods 설치
sudo gem install cocoapods

# 3. flutter 프로젝트 접근
cd WarmBoysApp

# 4. 패키지 다운로드
flutter pub get

# 5. 앱 실행
flutter run
```

</br>
