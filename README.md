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
docker info
Client:
 Version:    29.9.2
 Context:    desktop-linux
 Debug Mode: false
 Plugins:
  agent: Docker AI Agent Runner (Docker Inc.)
    Version:  v1.152.0
    Path:     C:\Users\User\.docker\cli-plugins\docker-agent.exe
  ai: Docker AI Agent - Ask Gordon (Docker Inc.)
    Version:  v1.33.0
    Path:     C:\Users\User\.docker\cli-plugins\docker-ai.exe
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.38.1
    Path:     C:\Users\User\.docker\cli-plugins\docker-buildx.exe
  compose: Docker Compose (Docker Inc.)
    Version:  v5.6.1
    Path:     C:\Users\User\.docker\cli-plugins\docker-compose.exe
  debug: Get a shell into any image or container (Docker Inc.)
    Version:  0.49.0
    Path:     C:\Users\User\.docker\cli-plugins\docker-debug.exe
  desktop: Docker Desktop commands (Docker Inc.)
    Version:  4.97.0
    Path:     C:\Users\User\.docker\cli-plugins\docker-desktop.exe
  dhi: CLI for managing Docker Hardened Images (Docker Inc.)
    Version:  v0.0.9
    Path:     C:\Users\User\.docker\cli-plugins\docker-dhi.exe
  extension: Manages Docker extensions (Docker Inc.)
    Version:  v0.2.32
    Path:     C:\Users\User\.docker\cli-plugins\docker-extension.exe
  init: Creates Docker-related starter files for your project (Docker Inc.)
    Version:  v1.4.1
    Path:     C:\Users\User\.docker\cli-plugins\docker-init.exe
  mcp: Docker MCP Plugin (Docker Inc.)
    Version:  v0.44.2
    Path:     C:\Users\User\.docker\cli-plugins\docker-mcp.exe
  model: Docker Model Runner (Docker Inc.)
    Version:  v1.2.9
    Path:     C:\Users\User\.docker\cli-plugins\docker-model.exe
  offload: Docker Offload (Docker Inc.)
    Version:  v0.7.21
    Path:     C:\Users\User\.docker\cli-plugins\docker-offload.exe
  pass: Docker Pass Secrets Manager Plugin (beta) (Docker Inc.)
    Version:  v0.3.2
    Path:     C:\Users\User\.docker\cli-plugins\docker-pass.exe
  sandbox: "docker sandbox" is deprecated, use Docker Sandboxes instead (Docker Inc.)
    Version:  v0.13.0
    Path:     C:\Users\User\.docker\cli-plugins\docker-sandbox.exe
  scout: Docker Scout (Docker Inc.)
    Version:  v1.27.0
    Path:     C:\Users\User\.docker\cli-plugins\docker-scout.exe

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 1
 Server Version: 29.9.2
 Storage Driver: overlayfs
  driver-type: io.containerd.snapshotter.v1
 Logging Driver: local
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Discovered Devices:
  cdi: docker.com/gpu=webgpu
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 nvidia runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: b7a25261e029d68978bbf290df0a62fc819b3c51
 runc version: v1.5.2-0-g29dd3dc2
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.18.54.1-microsoft-standard-WSL2
 Operating System: Docker Desktop
 OSType: linux
 Architecture: x86_64
 CPUs: 8
 Total Memory: 7.605GiB
 Name: docker-desktop
 ID: fceb5fe4-ef53-46d9-9cb9-5eac966b3f48
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 HTTP Proxy: http.docker.internal:3128
 HTTPS Proxy: http.docker.internal:3128
 No Proxy: hubproxy.docker.internal
 Labels:
  com.docker.desktop.address=npipe://\\.\pipe\docker_cli
 Experimental: false
 Insecure Registries:
  hubproxy.docker.internal:5555
  127.0.0.0/8
  ::1/128
 Live Restore Enabled: false
 Firewall Backend: iptables

실행 명령어 :
docker run --rm hello-world

실행 결과 값 :
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



## 5. 트러블슈팅

실습 중 발생한 오류와 해결 방법을 실제 경험을 바탕으로 기록합니다.

(추후 작성)

## 6. 증거 자료

실습 화면 캡처와 검증 결과를 추후 추가합니다.
