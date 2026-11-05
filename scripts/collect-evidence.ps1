[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$evidenceDir = Join-Path $repoRoot "evidence"
$runId = Get-Date -Format "yyyyMMddHHmmssfff"
$runStamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssK"
$statusPath = Join-Path $evidenceDir "23-collection-status.txt"
$backupPath = Join-Path $evidenceDir "codyssey-practice-volume-backup.tar.gz"

$webName = "codyssey-web-$runId"
$ubuntuName = "codyssey-ubuntu-$runId"
$bindName = "codyssey-bind-$runId"
$volumeOneName = "codyssey-volume-one-$runId"
$volumeTwoName = "codyssey-volume-two-$runId"
$volumeName = "codyssey-practice-volume-$runId"
$containerNames = @($webName, $ubuntuName, $bindName, $volumeOneName, $volumeTwoName)
$bindDir = Join-Path $evidenceDir "bind-mount-live-$runId"
$cliPracticeDir = Join-Path $evidenceDir "cli-practice-$runId"
$completed = $false
$failureMessage = ""

New-Item -ItemType Directory -Force -Path $evidenceDir | Out-Null
Get-ChildItem -LiteralPath $evidenceDir -Filter "*.txt" -File | Remove-Item -Force
Get-ChildItem -LiteralPath $evidenceDir -Filter "*.tar.gz" -File | Remove-Item -Force

function Invoke-LoggedCommand {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$DisplayCommand,
        [Parameter(Mandatory = $true)][string]$FilePath,
        [Parameter(Mandatory = $true)][string[]]$Arguments
    )

    $logPath = Join-Path $evidenceDir "$Name.txt"
    @(
        "# Captured: $runStamp"
        "# Run ID: $runId"
        "PS> $DisplayCommand"
    ) | Set-Content -Encoding utf8 -Path $logPath

    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    $exitCode = 0
    try {
        & $FilePath @Arguments 2>&1 | ForEach-Object {
            if ($_ -is [System.Management.Automation.ErrorRecord]) {
                $line = [string]$_.Exception.Message
            }
            else {
                $line = [string]$_
            }
            if ($env:USERPROFILE) {
                $line = $line -replace [regex]::Escape($env:USERPROFILE), "<user-profile>"
            }
            $line = $line -replace [regex]::Escape($repoRoot), "<repo-root>"
            $line = $line.TrimEnd()
            Add-Content -Encoding utf8 -Path $logPath -Value $line
            Write-Output $line
        }
        $exitCode = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }
    if ($exitCode -ne 0) {
        throw "Command failed: $DisplayCommand (exit code $exitCode)"
    }
}

function Remove-TestContainer {
    param([string]$Name)
    $existingContainers = @(& docker ps -a --format "{{.Names}}")
    if ($existingContainers -contains $Name) {
        & docker rm -f $Name | Out-Null
    }
}

function Remove-TestVolume {
    param([string]$Name)
    $existingVolumes = @(& docker volume ls --format "{{.Name}}")
    if ($existingVolumes -contains $Name) {
        & docker volume rm $Name | Out-Null
    }
}

function Wait-HttpContent {
    param(
        [Parameter(Mandatory = $true)][string]$Uri,
        [Parameter(Mandatory = $true)][string]$ExpectedText
    )

    for ($attempt = 1; $attempt -le 20; $attempt++) {
        try {
            $response = Invoke-WebRequest -UseBasicParsing -Uri $Uri -TimeoutSec 3
            if ($response.StatusCode -eq 200 -and $response.Content -match [regex]::Escape($ExpectedText)) {
                return
            }
        }
        catch {
            # The container may still be starting. Retry before failing the run.
        }
        Start-Sleep -Milliseconds 500
    }
    throw "HTTP readiness check failed: $Uri did not return 200 with '$ExpectedText'."
}

function Write-TerminalOperationsEvidence {
    $logPath = Join-Path $evidenceDir "22-terminal-operations.txt"
    New-Item -ItemType Directory -Force -Path $cliPracticeDir | Out-Null
    $sourceFile = Join-Path $cliPracticeDir "source.txt"
    $emptyFile = Join-Path $cliPracticeDir "empty.txt"
    $copyFile = Join-Path $cliPracticeDir "copy.txt"
    $movedFile = Join-Path $cliPracticeDir "moved.txt"
    $renamedFile = Join-Path $cliPracticeDir "renamed.txt"

    @(
        "# Captured: $runStamp"
        "# Run ID: $runId"
        "PS> pwd; Get-ChildItem -Force; New-Item; Set-Content; New-Item (empty); Copy-Item; Move-Item; Rename-Item; Get-Content; Remove-Item"
        "PWD: <repo-root>"
    ) | Set-Content -Encoding utf8 -Path $logPath

    Set-Content -Encoding utf8 -Path $sourceFile -Value "cli-content"
    New-Item -ItemType File -Path $emptyFile | Out-Null
    Add-Content -Encoding utf8 -Path $logPath -Value "After create: $((Get-ChildItem -LiteralPath $cliPracticeDir -Force).Name -join ', ')"
    Copy-Item -LiteralPath $sourceFile -Destination $copyFile
    Move-Item -LiteralPath $copyFile -Destination $movedFile
    Rename-Item -LiteralPath $movedFile -NewName "renamed.txt"
    $content = Get-Content -Raw -LiteralPath $renamedFile
    Add-Content -Encoding utf8 -Path $logPath -Value "After copy/move/rename: $((Get-ChildItem -LiteralPath $cliPracticeDir -Force).Name -join ', ')"
    Add-Content -Encoding utf8 -Path $logPath -Value "Content check: $content"
    Remove-Item -LiteralPath $renamedFile
    Add-Content -Encoding utf8 -Path $logPath -Value "After delete: $((Get-ChildItem -LiteralPath $cliPracticeDir -Force).Name -join ', ')"
}

function Write-GitEvidence {
    $logPath = Join-Path $evidenceDir "03-git-environment.txt"
    $name = git config --get user.name
    $email = git config --get user.email
    $defaultBranch = git config --get init.defaultBranch
    @(
        "# Captured: $runStamp"
        "# Run ID: $runId"
        "PS> git --version; git config --get user.name; git config --get init.defaultBranch; git remote -v; git log --oneline --decorate -5"
        "git version: $(git --version)"
        "user.name: $(if ($name) { 'configured' } else { 'missing' })"
        "user.email: redacted"
        "init.defaultBranch: $(if ($defaultBranch) { $defaultBranch } else { 'missing' })"
        "branch: $(git branch --show-current)"
    ) | Set-Content -Encoding utf8 -Path $logPath
    git remote -v | ForEach-Object { Add-Content -Encoding utf8 -Path $logPath -Value ([string]$_) }
    git log --oneline --decorate -5 | ForEach-Object { Add-Content -Encoding utf8 -Path $logPath -Value ([string]$_) }
}

try {
    Invoke-LoggedCommand -Name "01-environment" -DisplayCommand "docker --version" -FilePath "docker" -Arguments @("--version")
    Invoke-LoggedCommand -Name "02-docker-info" -DisplayCommand "docker info" -FilePath "docker" -Arguments @("info")

    Write-GitEvidence

    Write-TerminalOperationsEvidence

    $permissionCommand = 'set -eu; touch permission-test.txt; mkdir -p permission-folder; echo [before]; ls -ld permission-test.txt permission-folder; echo [after]; chmod 600 permission-test.txt; chmod 700 permission-folder; ls -ld permission-test.txt permission-folder; echo [mode-check]; stat -c %a permission-test.txt; stat -c %a permission-folder'
    Invoke-LoggedCommand -Name "04-permissions" -DisplayCommand "docker run --rm ubuntu:24.04 bash -lc <permission-check>" -FilePath "docker" -Arguments @("run", "--rm", "ubuntu:24.04", "bash", "-lc", $permissionCommand)
    Invoke-LoggedCommand -Name "05-hello-world" -DisplayCommand "docker run --rm hello-world" -FilePath "docker" -Arguments @("run", "--rm", "hello-world")

    Invoke-LoggedCommand -Name "06-ubuntu-container" -DisplayCommand "docker run -d --name $ubuntuName ubuntu:24.04 sleep 120" -FilePath "docker" -Arguments @("run", "-d", "--name", $ubuntuName, "ubuntu:24.04", "sleep", "120")
    Invoke-LoggedCommand -Name "07-ubuntu-exec" -DisplayCommand "docker exec $ubuntuName bash -lc 'pwd; whoami; ls -la; echo container-exec-ok'" -FilePath "docker" -Arguments @("exec", $ubuntuName, "bash", "-lc", "pwd; whoami; ls -la; echo container-exec-ok")

    Invoke-LoggedCommand -Name "08-build" -DisplayCommand "docker build -t my-web:1.0 ." -FilePath "docker" -Arguments @("build", "-t", "my-web:1.0", $repoRoot)
    Invoke-LoggedCommand -Name "09-run-web" -DisplayCommand "docker run -d -p 8080:80 --name $webName my-web:1.0" -FilePath "docker" -Arguments @("run", "-d", "-p", "8080:80", "--name", $webName, "my-web:1.0")
    Wait-HttpContent -Uri "http://localhost:8080" -ExpectedText "My First Container"
    Invoke-LoggedCommand -Name "10-curl-web" -DisplayCommand "curl.exe -sS --fail-with-body -i http://localhost:8080" -FilePath "curl.exe" -Arguments @("-sS", "--fail-with-body", "-i", "http://localhost:8080")
    $operationsCommand = "docker ps -a; docker images; docker logs $webName; docker stats --no-stream $webName"
    Invoke-LoggedCommand -Name "11-docker-operations" -DisplayCommand $operationsCommand -FilePath "powershell" -Arguments @("-NoProfile", "-Command", $operationsCommand)

    New-Item -ItemType Directory -Force -Path $bindDir | Out-Null
    $bindFile = Join-Path $bindDir "index.html"
    Set-Content -Encoding utf8 -Path $bindFile -Value "<h1>bind-before</h1>"
    $bindSource = (Resolve-Path $bindDir).Path
    Invoke-LoggedCommand -Name "12-bind-mount" -DisplayCommand "docker run -d --name $bindName -p 8081:80 --mount type=bind,source=<evidence>/bind-mount-live,target=/usr/share/nginx/html nginx:alpine" -FilePath "docker" -Arguments @("run", "-d", "--name", $bindName, "-p", "8081:80", "--mount", "type=bind,source=$bindSource,target=/usr/share/nginx/html", "nginx:alpine")
    Wait-HttpContent -Uri "http://localhost:8081" -ExpectedText "bind-before"
    Invoke-LoggedCommand -Name "13-bind-before" -DisplayCommand "curl.exe -sS --fail-with-body http://localhost:8081" -FilePath "curl.exe" -Arguments @("-sS", "--fail-with-body", "http://localhost:8081")
    Set-Content -Encoding utf8 -Path $bindFile -Value "<h1>bind-after</h1>"
    Wait-HttpContent -Uri "http://localhost:8081" -ExpectedText "bind-after"
    Invoke-LoggedCommand -Name "14-bind-after" -DisplayCommand "curl.exe -sS --fail-with-body http://localhost:8081" -FilePath "curl.exe" -Arguments @("-sS", "--fail-with-body", "http://localhost:8081")

    Invoke-LoggedCommand -Name "15-volume-create" -DisplayCommand "docker volume create $volumeName" -FilePath "docker" -Arguments @("volume", "create", $volumeName)
    Invoke-LoggedCommand -Name "16-volume-write" -DisplayCommand "docker run -d --name $volumeOneName -v ${volumeName}:/data alpine:3.20 sleep 120" -FilePath "docker" -Arguments @("run", "-d", "--name", $volumeOneName, "-v", "${volumeName}:/data", "alpine:3.20", "sleep", "120")
    Invoke-LoggedCommand -Name "17-volume-before-delete" -DisplayCommand "docker exec $volumeOneName sh -c 'echo persistent-data > /data/test.txt; cat /data/test.txt'" -FilePath "docker" -Arguments @("exec", $volumeOneName, "sh", "-c", "echo persistent-data > /data/test.txt; cat /data/test.txt")
    Remove-TestContainer $volumeOneName
    Invoke-LoggedCommand -Name "18-volume-after-delete" -DisplayCommand "docker run --rm --name $volumeTwoName -v ${volumeName}:/data alpine:3.20 cat /data/test.txt" -FilePath "docker" -Arguments @("run", "--rm", "--name", $volumeTwoName, "-v", "${volumeName}:/data", "alpine:3.20", "cat", "/data/test.txt")
    Invoke-LoggedCommand -Name "19-volume-inspect" -DisplayCommand "docker volume inspect $volumeName" -FilePath "docker" -Arguments @("volume", "inspect", $volumeName)

    Invoke-LoggedCommand -Name "20-volume-backup" -DisplayCommand "docker run --rm -v ${volumeName}:/volume -v <repo>/evidence:/backup alpine:3.20 tar czf /backup/codyssey-practice-volume-backup.tar.gz -C /volume ." -FilePath "docker" -Arguments @("run", "--rm", "-v", "${volumeName}:/volume", "-v", "$evidenceDir`:/backup", "alpine:3.20", "tar", "czf", "/backup/codyssey-practice-volume-backup.tar.gz", "-C", "/volume", ".")
    if (-not (Test-Path -LiteralPath $backupPath)) {
        throw "Volume backup was not created: $backupPath"
    }
    Invoke-LoggedCommand -Name "21-volume-backup-list" -DisplayCommand "tar.exe -tzf .\evidence\codyssey-practice-volume-backup.tar.gz" -FilePath "tar.exe" -Arguments @("-tzf", $backupPath)

    $completed = $true
}
catch {
    $failureMessage = $_.Exception.Message
    throw
}
finally {
    foreach ($containerName in $containerNames) {
        try { Remove-TestContainer $containerName } catch { }
    }
    try { Remove-TestVolume $volumeName } catch { }
    if (Test-Path -LiteralPath $bindDir) { Remove-Item -LiteralPath $bindDir -Recurse -Force }
    if (Test-Path -LiteralPath $cliPracticeDir) { Remove-Item -LiteralPath $cliPracticeDir -Recurse -Force }

    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    Get-ChildItem -LiteralPath $evidenceDir -Filter "*.txt" -File | ForEach-Object {
        $content = [System.IO.File]::ReadAllText($_.FullName)
        [System.IO.File]::WriteAllText($_.FullName, $content.TrimEnd() + [Environment]::NewLine, $utf8NoBom)
    }

    if ($completed) {
        @(
            "status: completed"
            "run-id: $runId"
            "captured-at: $runStamp"
            "message: all evidence commands completed successfully"
        ) | Set-Content -Encoding utf8 -Path $statusPath
        Write-Host "Evidence collection completed: $evidenceDir"
    }
    else {
        @(
            "status: failed"
            "run-id: $runId"
            "captured-at: $runStamp"
            "message: $failureMessage"
        ) | Set-Content -Encoding utf8 -Path $statusPath
    }
}
