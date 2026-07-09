#Requires -Version 7.0
<#
.SYNOPSIS
    Rebrand opencode → nobody-ai
.DESCRIPTION
    Rename all internal references from opencode to nobody-ai
.EXAMPLE
    .\script\rebrand.ps1
#>

param(
    [Parameter(Mandatory=$false)]
    [string]$NewName = "nobody-ai",
    
    [Parameter(Mandatory=$false)]
    [string]$DisplayName = "Nobody AI"
)

$ErrorActionPreference = "Stop"
$rootDir = "D:\OpenCode\opencode"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Rebranding: opencode → $NewName" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. Rename binary files
Write-Host "1. Renaming binary files..." -ForegroundColor Yellow
$binFiles = @(
    "packages/opencode/bin/opencode",
    "packages/opencode/dist/opencode"
)

foreach ($file in $binFiles) {
    $path = Join-Path $rootDir $file
    $newPath = Join-Path $rootDir ($file -replace "opencode$", $NewName)
    if (Test-Path $path) {
        Rename-Item -Path $path -NewName $NewName -Force
        Write-Host "   ✅ $file → $NewName" -ForegroundColor Green
    }
}

# 2. Update package.json bin fields
Write-Host ""
Write-Host "2. Updating package.json bin fields..." -ForegroundColor Yellow
$packageFiles = Get-ChildItem -Path $rootDir -Filter "package.json" -Recurse | Where-Object { $_.FullName -notlike "*node_modules*" }

foreach ($pkg in $packageFiles) {
    $content = Get-Content $pkg.FullName -Raw | ConvertFrom-Json
    if ($content.bin) {
        $modified = $false
        $newBin = @{}
        foreach ($prop in $content.bin.PSObject.Properties) {
            $value = $prop.Value
            if ($value -match "opencode") {
                $value = $value -replace "opencode", $NewName
                $modified = $true
            }
            $newBin[$prop.Name -replace "opencode", $NewName] = $value
        }
        if ($modified) {
            $content.bin = $newBin
            $content | ConvertTo-Json -Depth 10 | Set-Content $pkg.FullName
            Write-Host "   ✅ $($pkg.Name)" -ForegroundColor Green
        }
    }
}

# 3. Update core branding strings
Write-Host ""
Write-Host "3. Updating core branding strings..." -ForegroundColor Yellow

$coreFiles = @(
    "packages/core/src/global.ts",
    "packages/core/src/shell.ts",
    "packages/core/src/observability/otlp.ts",
    "packages/tui/src/attention.ts",
    "packages/tui/src/context/theme.tsx",
    "packages/tui/src/context/editor.ts"
)

foreach ($file in $coreFiles) {
    $path = Join-Path $rootDir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        $original = $content
        
        # Replace app name
        $content = $content -replace 'const app = "opencode"', "const app = `"$NewName`""
        $content = $content -replace 'serviceName: "opencode"', "serviceName: `"$NewName`""
        $content = $content -replace 'const DEFAULT_TITLE = "opencode"', "const DEFAULT_TITLE = `"$NewName`""
        $content = $content -replace 'clientInfo: \{ name: "opencode"', "clientInfo: { name: `"$NewName`""
        $content = $content -replace 'active: "opencode"', "active: `"$NewName`""
        $content = $content -replace '"opencode"', "`"$NewName`""
        
        if ($content -ne $original) {
            Set-Content -Path $path -Value $content
            Write-Host "   ✅ $file" -ForegroundColor Green
        }
    }
}

# 4. Update provider files
Write-Host ""
Write-Host "4. Updating provider files..." -ForegroundColor Yellow

$providerFiles = Get-ChildItem -Path "$rootDir/packages/core/src/plugin/provider" -Filter "*.ts" -ErrorAction SilentlyContinue

foreach ($file in $providerFiles) {
    $content = Get-Content $file.FullName -Raw
    $original = $content
    
    # Update X-Title headers
    $content = $content -replace '"X-Title": "opencode"', "`"X-Title`": `"$NewName`""
    $content = $content -replace '"x-title": "opencode"', "`"x-title`": `"$NewName`""
    $content = $content -replace '"X-Source": "opencode"', "`"X-Source`": `"$NewName`""
    $content = $content -replace 'originator: "opencode"', "originator: `"$NewName`""
    $content = $content -replace '"User-Agent": "opencode"', "`"User-Agent`": `"$NewName`""
    $content = $content -replace "integrationID: Integration\.ID\.make\(`"opencode`"\)", "integrationID: Integration.ID.make(`"$NewName`")"
    $content = $content -replace 'id: "opencode"', "id: `"$NewName`""
    
    if ($content -ne $original) {
        Set-Content -Path $file.FullName -Value $content
        Write-Host "   ✅ $($file.Name)" -ForegroundColor Green
    }
}

# 5. Update desktop files
Write-Host ""
Write-Host "5. Updating desktop files..." -ForegroundColor Yellow

$desktopFiles = @(
    "packages/desktop/src/main/index.ts",
    "packages/desktop/src/main/logging.ts",
    "packages/desktop/src/main/sidecar.ts"
)

foreach ($file in $desktopFiles) {
    $path = Join-Path $rootDir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        $original = $content
        
        $content = $content -replace 'app\.setAsDefaultProtocolClient\("opencode"\)', "app.setAsDefaultProtocolClient(`"$NewName`")"
        $content = $content -replace '"opencode"', "`"$NewName`""
        
        if ($content -ne $original) {
            Set-Content -Path $path -Value $content
            Write-Host "   ✅ $file" -ForegroundColor Green
        }
    }
}

# 6. Update TUI files
Write-Host ""
Write-Host "6. Updating TUI files..." -ForegroundColor Yellow

$tuiFiles = @(
    "packages/tui/src/component/dialog-model.tsx",
    "packages/tui/src/feature-plugins/sidebar/footer.tsx",
    "packages/tui/src/feature-plugins/home/tips.tsx",
    "packages/tui/src/prompt/traits.ts",
    "packages/tui/src/routes/session/index.tsx"
)

foreach ($file in $tuiFiles) {
    $path = Join-Path $rootDir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        $original = $content
        
        $content = $content -replace '"opencode"', "`"$NewName`""
        $content = $content -replace "opencode-go", "$NewName-go"
        
        if ($content -ne $original) {
            Set-Content -Path $path -Value $content
            Write-Host "   ✅ $file" -ForegroundColor Green
        }
    }
}

# 7. Update electron-builder config
Write-Host ""
Write-Host "7. Updating electron-builder config..." -ForegroundColor Yellow

$electronConfig = Join-Path $rootDir "packages/desktop/electron-builder.config.ts"
if (Test-Path $electronConfig) {
    $content = Get-Content $electronConfig -Raw
    $original = $content
    
    $content = $content -replace 'protocols: \{ name: "OpenCode Beta"', "protocols: { name: `"$DisplayName Beta`""
    $content = $content -replace 'protocols: \{ name: "OpenCode"', "protocols: { name: `"$DisplayName`""
    $content = $content -replace 'schemes: \["opencode"\]', "schemes: [`"$NewName`"]"
    $content = $content -replace '"opencode"', "`"$NewName`""
    
    if ($content -ne $original) {
        Set-Content -Path $electronConfig -Value $content
        Write-Host "   ✅ electron-builder.config.ts" -ForegroundColor Green
    }
}

# 8. Update global config
Write-Host ""
Write-Host "8. Updating global config..." -ForegroundColor Yellow

$configFiles = @(
    "packages/opencode/src/config/config.ts",
    "packages/opencode/src/installation/index.ts"
)

foreach ($file in $configFiles) {
    $path = Join-Path $rootDir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        $original = $content
        
        $content = $content -replace '"opencode"', "`"$NewName`""
        
        if ($content -ne $original) {
            Set-Content -Path $path -Value $content
            Write-Host "   ✅ $file" -ForegroundColor Green
        }
    }
}

# 9. Update project.ts (store path)
Write-Host ""
Write-Host "9. Updating project paths..." -ForegroundColor Yellow

$projectFile = Join-Path $rootDir "packages/core/src/project.ts"
if (Test-Path $projectFile) {
    $content = Get-Content $projectFile -Raw
    $original = $content
    
    $content = $content -replace 'path\.join\(dir, "opencode"\)', "path.join(dir, `"$NewName`")"
    $content = $content -replace 'path\.join\(input\.store, "opencode"\)', "path.join(input.store, `"$NewName`")"
    
    if ($content -ne $original) {
        Set-Content -Path $projectFile -Value $content
        Write-Host "   ✅ project.ts" -ForegroundColor Green
    }
}

# 10. Update install script
Write-Host ""
Write-Host "10. Updating install script..." -ForegroundColor Yellow

$installScript = Join-Path $rootDir "install"
if (Test-Path $installScript) {
    $content = Get-Content $installScript -Raw
    $original = $content
    
    $content = $content -replace 'APP=opencode', "APP=$NewName"
    $content = $content -replace 'OpenCode Installer', "$DisplayName Installer"
    $content = $content -replace 'opencode\.ai/docs', "nobody0x.com/docs"
    $content = $content -replace 'opencode\.ai', "nobody0x.com"
    $content = $content -replace '"opencode"', "`"$NewName`""
    
    if ($content -ne $original) {
        Set-Content -Path $installScript -Value $content
        Write-Host "   ✅ install" -ForegroundColor Green
    }
}

# 11. Update install.ps1
Write-Host ""
Write-Host "11. Updating install.ps1..." -ForegroundColor Yellow

$installPs1 = Join-Path $rootDir "install.ps1"
if (Test-Path $installPs1) {
    $content = Get-Content $installPs1 -Raw
    $original = $content
    
    $content = $content -replace 'Nobody AI Installer', "$DisplayName Installer"
    $content = $content -replace 'nobody-ai\.exe', "$NewName.exe"
    $content = $content -replace '"nobody-ai"', "`"$NewName`""
    
    if ($content -ne $original) {
        Set-Content -Path $installPs1 -Value $content
        Write-Host "   ✅ install.ps1" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Rebranding Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Run: bun install" -ForegroundColor White
Write-Host "  2. Run: bun run build" -ForegroundColor White
Write-Host "  3. Test locally" -ForegroundColor White
Write-Host "  4. Commit and push" -ForegroundColor White
Write-Host "  5. Create new release" -ForegroundColor White
Write-Host ""
