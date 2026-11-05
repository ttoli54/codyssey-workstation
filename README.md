# 내 컴퓨터에 개발자용 작업실 꾸미기

## 1. 프로젝트 소개

Windows 11 환경에서 개발자용 작업 환경을 구성하고 터미널, Git, Docker의 기본 사용법을 실습한 프로젝트입니다.

실습 과정과 실행 결과, 오류 해결 방법을 기록하여 다른 사람도 따라 할 수 있도록 정리했습니다.

## 2. 개발 환경

- 운영체제: Windows 11
- 터미널: PowerShell
- 컨테이너 환경: Docker Desktop
- Linux 이미지: Ubuntu 24.04
- 웹 서버 이미지: Nginx
- 버전 관리: Git
- 저장소: https://github.com/ttoli54/codyssey-workstation

## 3. 실습 내용

### 3-1. Git 환경 구성

- Git 설치 및 버전 확인
- Git 사용자 이름과 이메일 설정
- 프로젝트 폴더에서 Git 저장소 초기화
- GitHub 원격 저장소 연결

### 3-2. Docker 기본 실습

- Docker Desktop 설치 및 실행
- `docker info`로 Docker 환경 확인
- `docker run hello-world`로 컨테이너 실행 확인
- Ubuntu 24.04 컨테이너 실행
- 컨테이너 내부에서 `pwd`, `whoami`, `ls`, `ls -la` 명령어 실습

### 3-3. Linux 파일 권한 실습

Ubuntu 컨테이너에서 파일과 폴더를 생성하고 권한을 변경했습니다.

```bash
chmod 600 permission-test.txt
chmod 700 permission-folder
```

- 변경 전 파일 권한: `-rw-r--r--`
- 변경 후 파일 권한: `-rw-------`
- 변경 전 폴더 권한: `drwxr-xr-x`
- 변경 후 폴더 권한: `drwx------`

### 3-4. Docker 이미지와 컨테이너

Dockerfile을 작성하여 Nginx 기반 웹 서버 이미지를 생성했습니다.

```dockerfile
FROM nginx
COPY index.html /usr/share/nginx/html/index.html
```

이미지 빌드 명령어:

```bash
docker build -t my-web .
```

컨테이너 실행 및 포트 연결:

```bash
docker run -d -p 8080:80 --name my-web my-web
```

브라우저에서 `http://localhost:8080`에 접속하여 웹 페이지가 표시되는 것을 확인했습니다.

### 3-5. 포트 매핑 실습

추가 컨테이너를 실행하고 포트 매핑을 확인했습니다.

- 호스트 포트 8081 → 컨테이너 포트 80
- 접속 주소: `http://localhost:8081`

### 3-6. 바인드 마운트 실습

내 컴퓨터의 폴더를 컨테이너 내부 웹 서버 폴더에 연결했습니다.

- 호스트 폴더: `bind-mount-practice`
- 컨테이너 경로: `/usr/share/nginx/html`
- 호스트 파일을 수정한 뒤 브라우저에서 변경 내용이 반영되는 것을 확인했습니다.

### 3-7. Docker 볼륨 실습

Docker 볼륨을 생성하고 데이터를 저장한 후 다른 컨테이너에서 동일한 데이터를 읽어 영속성을 확인했습니다.

- 볼륨 이름: `codyssey-practice-volume`
- 저장 파일: `/data/test.txt`

## 4. 오류 해결 기록

### 오류 1. Docker 엔진 연결 오류

- 원인: Docker Desktop 엔진이 준비되기 전에 명령어를 실행했습니다.
- 해결: Docker Desktop을 실행하고 엔진이 정상적으로 시작된 후 다시 확인했습니다.

### 오류 2. Git 명령어 인식 오류

- 원인: Git 설치 경로가 PowerShell PATH에 등록되지 않았습니다.
- 해결: Git 실행 경로를 현재 PowerShell PATH에 추가하여 Git 명령어가 실행되도록 했습니다.

## 5. 프로젝트 파일 구성

```text
codyssey-workstation/
├── bind-mount-practice/
│   └── index.html
├── 1.png
├── 2.png
├── 3.png
├── 4.png
├── 5.png
├── 6.png
├── 07-permission-before.png
├── 08-permission-after.png
├── Dockerfile
├── index.html
└── README.md
```

## 6. 실습 결과 및 증빙 자료
### Git 설치 확인

실행 명령어:

```powershell
git --version
```

실행 결과:

```text
git version 2.56.0.windows.4
```


### Git 저장소 초기화

실행 명령어:

```powershell
git init
```

실행 결과:

```text
Initialized empty Git repository
```

### 터미널 기본 파일 관리 실습

실행 명령어 : 
```powershell
New-Item -ItemType File .\app\permissions-test.txt
```

실행 결과 :
디렉터리: C:\Users\User\desktop\codyssey-workstation\app


Mode                 LastWriteTime         Length Name                                        
----                 -------------         ------ ----                                        
-a----      2026-11-02   오후 2:48              0 permissions-test.txt

변경 전 권한 확인

icacls .\app\permissions-test.txt

###파일 및 디렉터리 권한 변경 실습

읽기 권한 추가

실행 명령어 :
icacls .\app\permissions-test.txt /grant:r "$($env:USERDOMAIN)\$($env:USERNAME):(R)"

### docker 설치 및 실행

docker --version

Docker version 29.9.2, build a82e528

실행 명령어 : 
docker info

<img width="1223" height="648" alt="1" src="https://github.com/user-attachments/assets/4393f6e4-65c0-4efa-b26e-882c5fa3931f" />

## 7. 마무리

이번 프로젝트를 통해 Windows 환경에서 개발 작업 공간을 구성하고 Git, Docker, Linux 명령어의 기본 사용법을 실습했습니다.

또한 Docker 이미지 생성, 컨테이너 실행, 포트 매핑, 바인드 마운트, 볼륨을 직접 경험하며 컨테이너 환경의 기본 개념을 익혔습니다.
