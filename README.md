# Template for Hackathon
이 레파지토리는 참여자들이 해커톤 결과물을 위한 레파지토리 생성시에 참고할 내용들을 담고 있습니다.
1. 레파지토리 생성
2. 레파지토리 구성
3. README.md 가이드라인
4. README.md 작성팁
<br/>


## 1. 레파지토리 생성
- <TODO: classroom link>
- 위 Github Classroom 링크에 접속해 본인 조의 github 레파지토리를 생성하세요.

<TODO: classroom createteam image>

- 레파지토리 생성 시, <TODO: format of repository name> 형식으로 생성하세요.
- 예를 들어, <TODO: example of repository name> 입니다.  
<br/>


## 2. 레파지토리 구성
- 레파지토리 내에 `README.md` 파일 생성하고 아래의 가이드라인과 작성팁을 참고하여 파일을 작성하세요.
- 레파지토리 내에 `docs` 폴더를 생성하고 폴더 내에는 과제 수행 하면서 작성한 각종 보고서, 발표자료를 올려둡니다.
- 그 밖에 레파지토리의 폴더 구성은 과제 결과물에 따라 자유롭게 구성하되 가급적 코드의 목적이나 기능에 따라 폴더를 나누어 구성하세요.  
<br/>


## 3. README.md 가이드라인
- README 파일 작성시에 아래의 5가지 항목의 내용은 필수적으로 포함해야 합니다.
- 아래의 5가지 항목이외에 프로젝트의 이해를 돕기위한 내용을 추가해도 됩니다.
- `SAMPLE_README.md`가 단순한 형태의 예제이니 참고하세요.


  ### 1. 프로젝트 소개
  프로젝트 명, 목적, 개요 등 프로젝트에 대한 간단한 소개글을 작성하세요.
    #### 1.1. 사용법
    프로젝트 결과를 확인하기 위해 필요한 소프트웨어 요구사항 및 설치법, 그리고 간단한 사용법을 작성하세요.
  
  ### 2. 팀원 소개
  프로젝트에 참여한 팀원들의 이름, 이메일, 역할을 포함해 팀원들을 소개하세요.
  
  ### 3. 구성도
    #### 3.1. 개발 환경
    * 스택(frontend, backend, designer..) 별 사용 기술을 작성해주세요.
    #### 3.2. 개발 기술 및 전략
    * 스택 별 사용한 기술을 선택한 이유를 작성해주세요.
    #### 3.3. 구성별 기능
    * 개발한 단위별 기능들에 대한 설명을 작성해주세요.
  
  ### 4. 소개 및 시연 영상
  프로젝트 소개 및 시연 영상을 넣으세요.
  
  ### 5. 해커톤 후기
  팀원 별 해커톤 참여 후기를 작성하세요.
<br/>


## 4. README.md 작성 팁
- 마크다운 언어를 이용해 README.md 파일을 작성할 때 참고할 수 있는 마크다운 언어 문법을 공유합니다.
- 다양한 예제와 보다 자세한 문법은 [이 문서](https://www.markdownguide.org/basic-syntax/)를 참고하세요.

### 4.1. 헤더 Header
```
# This is a Header 1
## This is a Header 2
### This is a Header 3
#### This is a Header 4
##### This is a Header 5
###### This is a Header 6
####### This is a Header 7 은 지원되지 않습니다.
```

# This is a Header 1
## This is a Header 2
### This is a Header 3
#### This is a Header 4
##### This is a Header 5
###### This is a Header 6
####### This is a Header 7 은 지원되지 않습니다.
<br />

### 4.2. 인용문 BlockQuote
```
> This is a first blockqute.
>	> This is a second blockqute.
>	>	> This is a third blockqute.
```
> This is a first blockqute.
>	> This is a second blockqute.
>	>	> This is a third blockqute.
<br />

### 4.3. 목록 List
* **Ordered List**
```
1. first
2. second
3. third  
```
1. first
2. second
3. third
<br />

* **Unordered List**
```
* 하나
  * 둘

+ 하나
  + 둘

- 하나
  - 둘
```
* 하나
  * 둘

+ 하나
  + 둘

- 하나
  - 둘
<br />

### 4.4. 코드 CodeBlock
* 코드 블럭 이용 '``'
```
여러줄 주석 "```" 이용
"```
#include <stdio.h>
int main(void){
  printf("Hello world!");
  return 0;
}
```"

단어 주석 "`" 이용
"`Hello world`"

* 큰 따움표(") 없이 사용하세요.
``` 
<br />

### 4.5. 링크 Link
```
[Title](link)
[부산대 소프트웨어융합교육원](https://swedu.pusan.ac.kr/swedu/index.do)

<link>
<https://swedu.pusan.ac.kr>
``` 
[부산대 소프트웨어융합교육원](https://swedu.pusan.ac.kr/swedu/index.do)

<https://swedu.pusan.ac.kr/swedu/index.do>  
<br />

### 4.6. 강조 Highlighting
```
*single asterisks*
_single underscores_
**double asterisks**
__double underscores__
~~cancelline~~
```
*single asterisks* <br />
_single underscores_ <br />
**double asterisks** <br />
__double underscores__ <br />
~~cancelline~~  <br />
<br />

### 4.7. 이미지 Image
```
![Alt text](/path/to/img.jpg)
![Alt text](/path/to/img.jpg "Optional title")
<img src="/path/to/img.jpg" width="450px" title="부산대학교" alt="Alt text"></img>
```
![부산대](https://www.pusan.ac.kr/_contents/kor/_Img/Layout/logo.png)
<br/>
![부산대](https://www.pusan.ac.kr/_contents/kor/_Img/Layout/logo.png "부산대학교")
<br/>
<img src="https://www.pusan.ac.kr/_contents/kor/_Img/Layout/logo.png" width="450px" title="부산대학교" alt="부산대"></img>
<br/>



















