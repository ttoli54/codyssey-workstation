# 사전평가 증거 보강 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** README와 실행 스크립트에 사전평가에서 요구한 실제 명령·출력·개념 설명·재현 절차를 추가한다.

**Architecture:** 기존 프로젝트 구조와 Dockerfile은 유지한다. `scripts/collect-evidence.ps1`가 Windows PowerShell에서 Docker/Git 검증 명령을 실행하고 `evidence/`에 실제 출력 로그를 저장하며, README는 해당 로그와 개념 설명을 연결한다.

**Tech Stack:** Markdown, PowerShell, Docker CLI, Git.

**Spec:** `미션1.txt` 및 제공된 AI 사전평가 결과.

## Global Constraints

- README만 읽어도 전체 수행 절차와 검증 위치를 파악할 수 있어야 한다.
- 명령어와 실제 출력은 코드블록 또는 링크된 로그 파일로 남긴다.
- 토큰, 비밀번호, 개인키, 인증 코드는 저장하지 않는다.
- Windows PowerShell/Docker Desktop 기준으로 작성하되 Linux 진단 명령도 함께 설명한다.
- 원격 저장소에는 자동 push하지 않는다.

## Review Focus

- Docker 엔진이 실행되지 않는 경우 오류 로그가 남고 원인·확인·조치 흐름이 설명되는가.
- 포트 8080이 이미 사용 중인 경우 프로세스와 컨테이너를 구분해 진단할 수 있는가.
- 바인드 마운트의 호스트 경로에 공백이 있어도 재현 절차가 깨지지 않는가.
- 볼륨을 사용하는 컨테이너를 삭제한 뒤 데이터가 다시 읽히는가.
- 로그에 개인 인증정보가 포함되지 않는가.

### Task 1: 실행 증거 수집 자동화

**Files:**
- Create: `scripts/collect-evidence.ps1`
- Create: `evidence/README.md`

- [ ] PowerShell 스크립트로 Docker 버전/엔진, Git 원격, 권한, hello-world, 이미지/컨테이너, 빌드/접속, 바인드 마운트, 볼륨 영속성 로그를 각각 저장한다.
- [ ] 실패 시 오류 출력을 숨기지 않고 해당 로그에 남긴다.
- [ ] 저장된 로그에 민감정보가 없는지 확인한다.

### Task 2: README 보완

**Files:**
- Modify: `README.md`

- [ ] 실제 증거 파일 인덱스와 재현 명령을 추가한다.
- [ ] 이미지/컨테이너, 네트워크 네임스페이스/포트포워딩, 절대/상대 경로, 권한 숫자 표기, 볼륨 백업을 설명한다.
- [ ] 포트 충돌 진단과 Docker/Git 트러블슈팅을 가설→확인→조치→결과 형식으로 보강한다.
- [ ] 디렉터리와 스크립트의 목적을 파일 트리에 표시한다.

### Task 3: 실행 및 문서 검증

**Files:**
- Create: `evidence/*.txt` (스크립트 실행 결과)

- [ ] `scripts/collect-evidence.ps1`를 실행한다.
- [ ] 모든 로그 파일이 생성되고 README 링크가 실제 파일을 가리키는지 확인한다.
- [ ] `git diff --check`와 Markdown 링크 대상 확인을 실행한다.
