# [팀프로젝트] 불멸의코더스 - 전과자 (I'M COOKIE)🍪
#### 🍪 '전과자'는 “과자에 대한 정보와 감상” 을 공유하는 플랫폼입니다 🍪
* 소비자들이 보다 편리하고 안전하게 과자를 선택할 수 있도록 도와주는 서비스
* 사용자들이 직접 리뷰와 평가를 남기고 공유할 수 있는 공간
* 현명한 선택을 위한 정확한 정보 제공
* 개인의 취향과 목적에 맞는 큐레이팅 서비스
* 소통과 정보, 경험 공유를 위한 커뮤니티

<br>

## 1. 제작 기간
#### `2023년 7월 28일 ~ 9월 7일`

<br>

## 2. 사용 기술
### `Back-end`
* Java 8
* Spring Framework 5.0.1, Spring MVC
  * Spring Security
  * Spring Scheduler
* Junit5
* Maven
* Mybatis
* IntelliJ

### `Front-end`
* HTML
* CSS
* JavaScript
* JQuery 3.7.0
* BootStrap 5.3.1

### `Deploy`
* AWS EC2, S3, RDS, CloudFront, Route 53, ALB
* Tomcat 9.0
* MySQL 8.0.32

### `Collaboration`
* Git, Sourcetree 
* Slack 
* Notion

### `External API`
* Naver, Kakao Social Login
* HACCP 식품정보 API


<br>

## 3. 기능 구현
* ##### `회원관리`
  * 소셜 로그인을 통한 회원가입
  * 일반 회원가입
     * 스프링 시큐리티 적용
     * 임시 비밀번호 발급 기능(SMS)
  * 마이페이지
    * 내 게시글 확인
    * 내 댓글 확인
  * 회원 등급 구분
  * 관리자 페이지

* ##### `엔터테인먼트`
  * 과자 이상형 월드컵
  * 과자 랭킹 기능
    * 구분별 평점에 따른 랭킹

* ##### `커뮤니티`
  * 자유게시판
  * 리뷰게시판
    * 과자 검색 후 평점 입력
  * 댓글
  * 쪽지 시스템
  * 내 게시글 댓글 알림

* ##### `데이터 관리`
  * DB 관리
    * 관련 API에서 데이터 끌어오기
      * JSON 데이터 분류별 파싱
    * DB 자동 최신화 기능
    * 스프링 스케쥴러 적용
  * WIKI
    * 키워드를 이용한 관련 과자 검색기능
    * 영양성분 정보 제공
    * 알레르기 유발 성분 정보 제공
      * 알레르기 유발 성분 선택적 제외 검색 기능
    * 과자 이미지 제공
  * 큐레이션
    * 사용자 알레르기 정보 수집
    * 과자 검색 기능에 활용


<br>

