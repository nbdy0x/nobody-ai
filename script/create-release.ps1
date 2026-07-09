#Requires -Version 7.0
<#
.SYNOPSIS
    Create release for nbdy0x/nobody-ai from anomalyco/opencode
.DESCRIPTION
    Download binaries from original repo and upload to new repo
.EXAMPLE
    .\script\create-release.ps1 -Version "1.17.15"
    .\script\create-release.ps1 -Version "1.17.15" -Token $env:GITHUB_TOKEN
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Version,
    
    [Parameter(Mandatory=$false)]
    [string]$Token = $env:GITHUB_TOKEN,
    
    [Parameter(Mandatory=$false)]
    [string]$SourceRepo = "anomalyco/opencode",
    
    [Parameter(Mandatory=$false)]
    [string]$TargetRepo = "nbdy0x/nobody-ai",
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# Assets to download
$assets = @(
    "opencode-linux-x64.tar.gz",
    "opencode-linux-arm64.tar.gz",
    "opencode-darwin-x64.zip",
    "opencode-darwin-arm64.zip",
    "opencode-windows-x64.zip",
    "opencode-windows-x64-baseline.zip",
    "opencode-windows-arm64.zip"
)

# Validate token
if (-not $Token -and -not $DryRun) {
    Write-Host "❌ GitHub token required!" -ForegroundColor Red
    Write-Host "Set `$env:GITHUB_TOKEN or use -Token parameter" -ForegroundColor Yellow
    exit 1
}

$headers = if ($Token) {
    @{
        "Authorization" = "Bearer $Token"
        "Accept" = "application/vnd.github+json"
        "X-GitHub-Api-Version" = "2022-11-28"
    }
} else { @{} }

$tag = "v$Version"
$tempDir = Join-Path $env:TEMP "release-$Version"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Release Creator: $TargetRepo" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📦 Version: $Version" -ForegroundColor Green
Write-Host "📤 Source: $SourceRepo" -ForegroundColor Yellow
Write-Host "📥 Target: $TargetRepo" -ForegroundColor Yellow
Write-Host ""

# Step 1: Check if release exists
Write-Host "1️⃣  Checking if release $tag exists..." -ForegroundColor Cyan
try {
    $release = Invoke-RestMethod -Uri "https://api.github.com/repos/$TargetRepo/releases/tags/$tag" -Headers $headers
    Write-Host "   ✅ Release already exists: $($release.html_url)" -ForegroundColor Green
    Write-Host ""
    Write-Host "Release URL: $($release.html_url)" -ForegroundColor Cyan
    exit 0
} catch {
    if ($_.Exception.Response.StatusCode -eq 404) {
        Write-Host "   ℹ️  Release not found, creating new one..." -ForegroundColor Yellow
    } else {
        throw
    }
}

# Step 2: Download assets
Write-Host ""
Write-Host "2️⃣  Downloading assets from $SourceRepo..." -ForegroundColor Cyan
$downloaded = @()

foreach ($asset in $assets) {
    $url = "https://github.com/$SourceRepo/releases/download/$tag/$asset"
    $output = Join-Path $tempDir $asset
    
    Write-Host "   📥 $asset... " -NoNewline
    try {
        Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing -ErrorAction Stop
        $size = (Get-Item $output).Length / 1MB
        Write-Host "✅ ($([math]::Round($size, 1)) MB)" -ForegroundColor Green
        $downloaded += $asset
    } catch {
        Write-Host "⚠️ skipped" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "   Downloaded: $($downloaded.Count)/$($assets.Count) assets" -ForegroundColor $(if ($downloaded.Count -gt 0) { "Green" } else { "Red" })

if ($downloaded.Count -eq 0) {
    Write-Host "❌ No assets downloaded!" -ForegroundColor Red
    exit 1
}

# Step 3: Create release
Write-Host ""
Write-Host "3️⃣  Creating release $tag..." -ForegroundColor Cyan

$releaseBody = @"
## What's Changed

This is a rebranded release from [anomalyco/opencode]($("https://github.com/$SourceRepo")).

### Installation

**macOS/Linux:**
``````bash
curl -fsSL https://raw.githubusercontent.com/$TargetRepo/dev/install | bash
``````

**Windows (PowerShell):**
``````powershell
irm https://raw.githubusercontent.com/$TargetRepo/dev/install.ps1 | iex
``````

**Manual Download:**
Download the appropriate binary for your platform from the assets below.

### Supported Platforms

| Platform | Architecture | File |
|----------|--------------|------|
| Linux | x64 | opencode-linux-x64.tar.gz |
| Linux | ARM64 | opencode-linux-arm64.tar.gz |
| macOS | x64 | opencode-darwin-x64.zip |
| macOS | ARM64 | opencode-darwin-arm64.zip |
| Windows | x64 | opencode-windows-x64.zip |
| Windows | x64 (baseline) | opencode-windows-x64-baseline.zip |
| Windows | ARM64 | opencode-windows-arm64.zip |

---

**Original project:** [anomalyco/opencode]($("https://github.com/$SourceRepo"))
**Documentation:** [opencode.ai/docs]($("https://opencode.ai/docs"))
"@

$releaseData = @{
    tag_name = $tag
    name = $tag
    body = $releaseBody
    draft = $false
    prerelease = $false
}

if ($DryRun) {
    Write-Host "   🏃 DRY RUN - Would create release with:" -ForegroundColor Yellow
    Write-Host "      Tag: $tag" -ForegroundColor Gray
    Write-Host "      Assets: $($downloaded -join ', ')" -ForegroundColor Gray
} else {
    try {
        $releaseJson = $releaseData | ConvertTo-Json
        $release = Invoke-RestMethod -Uri "https://api.github.com/repos/$TargetRepo/releases" -Method Post -Headers $headers -Body $releaseJson -ContentType "application/json"
        Write-Host "   ✅ Release created: $($release.html_url)" -ForegroundColor Green
    } catch {
        Write-Host "   ❌ Failed to create release: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}

# Step 4: Upload assets
Write-Host ""
Write-Host "4️⃣  Uploading assets..." -ForegroundColor Cyan

$uploaded = 0
foreach ($asset in $downloaded) {
    $file = Join-Path $tempDir $asset
    $uploadUrl = "$($release.upload_url)?name=$asset"
    
    Write-Host "   📤 $asset... " -NoNewline
    try {
        $fileBytes = [System.IO.File]::ReadAllBytes($file)
        $result = Invoke-RestMethod -Uri $uploadUrl -Method Post -Headers $headers -Body $fileBytes -ContentType "application/octet-stream"
        Write-Host "✅" -ForegroundColor Green
        $uploaded++
    } catch {
        Write-Host "❌ $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Cleanup
Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Release: $($release.html_url)" -ForegroundColor Green
Write-Host "  Assets: $uploaded/$($downloaded.Count) uploaded" -ForegroundColor $(if ($uploaded -eq $downloaded.Count) { "Green" } else { "Yellow" })
Write-Host ""
Write-Host "🧪 Test install:" -ForegroundColor Yellow
Write-Host "   curl -fsSL https://raw.githubusercontent.com/$TargetRepo/dev/install | bash" -ForegroundColor White
Write-Host ""
