#Requires -Version 7.0
<#
.SYNOPSIS
    Install nobody-ai CLI
.DESCRIPTION
    Download and install nobody-ai CLI binary
.EXAMPLE
    irm https://raw.githubusercontent.com/nbdy0x/nobody-ai/dev/install.ps1 | iex
    .\install.ps1
    .\install.ps1 -Version "1.17.15"
#>

param(
    [Parameter(Mandatory=$false)]
    [string]$Version,
    
    [Parameter(Mandatory=$false)]
    [string]$InstallDir = "$env:USERPROFILE\.nobody-ai\bin"
)

$ErrorActionPreference = "Stop"
$repo = "nbdy0x/nobody-ai"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Nobody AI Installer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get latest version if not specified
if (-not $Version) {
    Write-Host "📦 Fetching latest version..." -ForegroundColor Yellow
    try {
        $release = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest"
        $Version = $release.tag_name -replace '^v', ''
        Write-Host "   Latest version: $Version" -ForegroundColor Green
    } catch {
        Write-Host "   ❌ Failed to fetch version: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "📦 Version: $Version" -ForegroundColor Green
}

# Detect platform
$arch = if ([System.Environment]::Is64BitOperatingSystem) {
    if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") { "arm64" } else { "x64" }
} else {
    Write-Host "❌ 32-bit systems not supported" -ForegroundColor Red
    exit 1
}

$platform = "windows"
$asset = "opencode-$platform-$arch.zip"
$tag = "v$Version"

Write-Host "💻 Platform: $platform-$arch" -ForegroundColor Green
Write-Host ""

# Create install directory
New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null

# Download
Write-Host "📥 Downloading $asset..." -ForegroundColor Yellow
$url = "https://github.com/$repo/releases/download/$tag/$asset"
$zipFile = Join-Path $env:TEMP "nobody-ai-$Version.zip"
$extractDir = Join-Path $env:TEMP "nobody-ai-extract"

try {
    Invoke-WebRequest -Uri $url -OutFile $zipFile -UseBasicParsing
    $size = (Get-Item $zipFile).Length / 1MB
    Write-Host "   Downloaded: $([math]::Round($size, 1)) MB" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Download failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "   URL: $url" -ForegroundColor Gray
    exit 1
}

# Extract
Write-Host "📂 Extracting..." -ForegroundColor Yellow
Expand-Archive -Path $zipFile -DestinationPath $extractDir -Force

# Find binary
$binary = Get-ChildItem -Path $extractDir -Filter "nobody-ai.exe" -Recurse | Select-Object -First 1
if (-not $binary) {
    # Try opencode.exe as fallback
    $binary = Get-ChildItem -Path $extractDir -Filter "opencode.exe" -Recurse | Select-Object -First 1
}

if (-not $binary) {
    Write-Host "   ❌ Binary not found in archive" -ForegroundColor Red
    Get-ChildItem $extractDir
    exit 1
}

# Install
Write-Host "📦 Installing..." -ForegroundColor Yellow
$exePath = Join-Path $InstallDir "nobody-ai.exe"
Copy-Item -Path $binary.FullName -Destination $exePath -Force

# Cleanup
Remove-Item -Path $zipFile -Force -ErrorAction SilentlyContinue
Remove-Item -Path $extractDir -Recurse -Force -ErrorAction SilentlyContinue

# Verify
Write-Host "✅ Verifying installation..." -ForegroundColor Yellow
& $exePath --version

# Add to PATH (if not already)
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$InstallDir*") {
    Write-Host ""
    Write-Host "📝 Adding to PATH..." -ForegroundColor Yellow
    [Environment]::SetEnvironmentVariable("Path", "$InstallDir;$currentPath", "User")
    $env:Path = "$InstallDir;$env:Path"
    Write-Host "   ✅ Added to user PATH" -ForegroundColor Green
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Installation Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📍 Installed to: $exePath" -ForegroundColor Green
Write-Host ""
Write-Host "🚀 Quick Start:" -ForegroundColor Yellow
Write-Host "   cd <your-project>" -ForegroundColor White
Write-Host "   nobody-ai" -ForegroundColor White
Write-Host ""
Write-Host "📚 Docs: https://nobody0x.com/docs" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  Restart your terminal for PATH changes to take effect" -ForegroundColor Yellow
Write-Host ""
