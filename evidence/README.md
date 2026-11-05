# 실행 증거

이 디렉터리의 `.txt` 파일은 `scripts/collect-evidence.ps1`를 실제 실행해 생성한 터미널 출력입니다.

- 로그에 포함된 시간, 이미지 ID, 컨테이너 ID, 파일 크기는 실행 환경에 따라 달라질 수 있습니다.
- `docker info`가 실패하면 Docker Desktop 또는 OrbStack을 먼저 실행한 뒤 같은 스크립트를 다시 실행합니다.
- 로그에 토큰, 비밀번호, 개인키, 인증 코드가 포함되지 않았는지 확인한 후 제출합니다.
- `codyssey-practice-volume-backup.tar.gz`는 볼륨 백업 예시이며, 필요하면 제출 전에 삭제할 수 있습니다.

생성되는 로그:

| 파일 | 검증 내용 |
| --- | --- |
| `01-environment.txt` | Docker 버전 |
| `02-docker-info.txt` | Docker 엔진/데몬 상태 |
| `03-git-environment.txt` | Git 버전, 사용자 설정(이메일 마스킹), 기본 브랜치, 원격 저장소, 최근 커밋 |
| `22-terminal-operations.txt` | 현재 위치, 목록, 생성, 내용, 빈 파일, 복사, 이동, 이름 변경, 삭제 |
| `04-permissions.txt` | Linux 권한 변경 전·후 `ls -ld` 및 숫자 모드 |
| `05-hello-world.txt` | 기본 컨테이너 실행 |
| `06-ubuntu-container.txt`, `07-ubuntu-exec.txt` | 컨테이너 실행과 `exec` |
| `08-build.txt` | Dockerfile 이미지 빌드 |
| `09-run-web.txt`, `10-curl-web.txt` | 포트 매핑과 HTTP 응답 |
| `11-docker-operations.txt` | `ps`, `images`, `logs`, `stats` |
| `12-bind-mount.txt` ~ `14-bind-after.txt` | 바인드 마운트 변경 반영 |
| `15-volume-create.txt` ~ `19-volume-inspect.txt` | 볼륨 생성·삭제 후 영속성 |
| `20-volume-backup.txt` | 볼륨 백업 |
| `21-volume-backup-list.txt` | 백업 아카이브 내부 파일 목록 |
| `23-collection-status.txt` | 현재 로그 세트의 성공/실패와 실행 ID |

수집기는 매 실행마다 고유한 컨테이너·볼륨 이름을 사용합니다. 기존 `codyssey-*` 리소스는 삭제하지 않습니다. 실행 시작 시 이전 수집 로그(`*.txt`)와 생성된 백업 아카이브만 교체하며, 실습용 이미지와 기존 컨테이너는 건드리지 않습니다.
