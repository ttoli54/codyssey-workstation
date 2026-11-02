# 내 컴퓨터에 개발자용 작업실 꾸미기

## 1. 프로젝트 소개

이 프로젝트는 Windows 11 환경에서 개발자용 작업 환경을 구성하고, 터미널, Git, Docker 등의 기본 사용법을 실습하는 과제입니다.

실습 과정과 실행 결과, 오류 해결 방법을 기록하여 다른 사람도 따라 할 수 있도록 정리합니다.

## 2. 개발 환경

| 항목 | 환경 |
|---|---|
| 운영체제 | Windows 11 |
| 편집기 | Visual Studio Code |
| 터미널 | PowerShell |
| Git 버전 | 2.56.0.windows.4 |
| 프로젝트 경로 | `C:\Users\User\Desktop\codyssey-workstation` |

## 3. 실습 진행 체크리스트

- [x] Git 설치 및 버전 확인
- [x] VS Code 터미널에서 Git 실행 확인
- [x] 프로젝트 디렉터리 생성
- [x] Git 저장소 초기화
- [x] README.md 파일 생성
- [ ] 터미널 기본 파일 관리 실습
- [ ] 파일 및 디렉터리 권한 변경 실습
- [ ] Docker 설치 및 실행 확인
- [ ] Docker 컨테이너 실습
- [ ] Dockerfile 작성 및 이미지 생성
- [ ] 웹 서버 포트 연결 실습
- [ ] Docker 볼륨 및 바인드 마운트 실습
- [ ] 트러블슈팅 사례 2건 기록
- [ ] GitHub 저장소 생성 및 연결
- [ ] 최종 결과 정리 및 제출

## 4. 실습 기록

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


### wsl 설치 및 실행

wsl --version
WSL 버전: 3.0.3.0
커널 버전: 6.18.54.1-1
WSLg 버전: 1.0.79
MSRDC 버전: 1.2.7391
Direct3D 버전: 1.611.1-81528511
DXCore 버전: 10.0.26100.1-240331-1435.ge-release
Windows 버전: 10.0.26300.9711


## 5. 트러블슈팅

실습 중 발생한 오류와 해결 방법을 실제 경험을 바탕으로 기록합니다.

(추후 작성)

## 6. 증거 자료

실습 화면 캡처와 검증 결과를 추후 추가합니다.
