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

실행 명령어 : 
docker info

실행 결과 :


 
실행 명령어 :
docker run --rm hello-world


실행 결과 값 :
<img width="1223" height="648" alt="1" src="https://github.com/user-attachments/assets/4393f6e4-65c0-4efa-b26e-882c5fa3931f" />

 docker run --rm hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4f55086f7dd0: Pull complete
d5e71e642bf5: Download complete
Digest: sha256:c567b231f65614688711a75f31518a064258a51d442117a3e771a3a8fdba78ef
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

### wsl 설치 및 실행

wsl --version
WSL 버전: 3.0.3.0
커널 버전: 6.18.54.1-1
WSLg 버전: 1.0.79
MSRDC 버전: 1.2.7391
Direct3D 버전: 1.611.1-81528511
DXCore 버전: 10.0.26100.1-240331-1435.ge-release
Windows 버전: 10.0.26300.9711


### Ubuntu 컨테이너 실행

명령어 실행값 :
docker run -it --name codyssey-ubuntu-practice ubuntu:24.04 bash

출력값 : 

<img width="960" height="1015" alt="2" src="https://github.com/user-attachments/assets/5e9ea743-912f-4838-9bd4-7b260401549c" />


Unable to find image 'ubuntu:24.04' locally
24.04: Pulling from library/ubuntu
7a48b8f0e5c7: Pull complete
98144013299c: Download complete
Digest: sha256:fe81560990fae86dc4743202b2cb4d3df98d0bcf949173cecef15ce1127ef852
Status: Downloaded newer image for ubuntu:24.04

root@697f219784f2:/# pwd
/
root@697f219784f2:/# whoami
root
root@697f219784f2:/#


ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var


 ls -la
total 56
drwxr-xr-x   1 root root 4096 Nov  2 08:03 .
drwxr-xr-x   1 root root 4096 Nov  2 08:03 ..
-rwxr-xr-x   1 root root    0 Nov  2 08:03 .dockerenv
lrwxrwxrwx   1 root root    7 Apr 22  2024 bin -> usr/bin
drwxr-xr-x   2 root root 4096 Apr 22  2024 boot
drwxr-xr-x   5 root root  360 Nov  2 08:03 dev
drwxr-xr-x   1 root root 4096 Nov  2 08:03 etc
drwxr-xr-x   3 root root 4096 Oct 24 14:12 home
lrwxrwxrwx   1 root root    7 Apr 22  2024 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Apr 22  2024 lib64 -> usr/lib64
drwxr-xr-x   2 root root 4096 Oct 24 14:05 media
drwxr-xr-x   2 root root 4096 Oct 24 14:05 mnt
drwxr-xr-x   2 root root 4096 Oct 24 14:05 opt
dr-xr-xr-x 174 root root    0 Nov  2 08:03 proc
drwx------   2 root root 4096 Oct 24 14:12 root
drwxr-xr-x   4 root root 4096 Oct 24 14:12 run
lrwxrwxrwx   1 root root    8 Apr 22  2024 sbin -> usr/sbin
drwxr-xr-x   2 root root 4096 Oct 24 14:05 srv
dr-xr-xr-x  12 root root    0 Nov  2 08:03 sys
drwxrwxrwt   2 root root 4096 Oct 24 14:12 tmp
drwxr-xr-x  12 root root 4096 Oct 24 14:05 usr
drwxr-xr-x  11 root root 4096 Oct 24 14:12 var

폴더 권한 확인

실행 명령어 :
ls -l permission-test.txt permission-folder

실행값 변경 전
<img width="968" height="1026" alt="3" src="https://github.com/user-attachments/assets/cdcf6a91-b8e3-49ff-8356-e5e35f4f914b" />
실행값 변경 후
<img width="968" height="1029" alt="4" src="https://github.com/user-attachments/assets/a8a864f1-fe27-47ca-8953-23357b5d2160" />


<img width="968" height="1028" alt="5" src="https://github.com/user-attachments/assets/134fd0c0-94a2-42dd-b273-18905d455016" />

## 5. 트러블슈팅

실습 중 발생한 오류와 해결 방법을 실제 경험을 바탕으로 기록합니다.

(추후 작성)

## 6. 증거 자료

실습 화면 캡처와 검증 결과를 추후 추가합니다.
