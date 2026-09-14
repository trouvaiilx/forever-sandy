<#
.SYNOPSIS
    Packages Forever Sandy into a Nexus Mods-compliant distribution zip archive.

.DESCRIPTION
    Extracts the version from init.lua and packages the 'bin' and 'r6' trees
    into dist/ForeverSandy-v<Version>.zip with correct folder hierarchy.

.PARAMETER Version
    Optional override for the release version string (defaults to version in init.lua).
#>

[CmdletBinding()]
param(
    [string]$Version = ""
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $ScriptDir

Write-Host "==> Starting Forever Sandy Release Packaging..." -ForegroundColor Cyan

# 1. Resolve Version
$InitLuaPath = Join-Path $ScriptDir "bin\x64\plugins\cyber_engine_tweaks\mods\ForeverSandy\init.lua"
if (-not (Test-Path $InitLuaPath)) {
    Write-Error "Could not find init.lua at '$InitLuaPath'."
    exit 1
}

if ([string]::IsNullOrWhiteSpace($Version)) {
    $VersionMatch = Select-String -Path $InitLuaPath -Pattern 'version\s*=\s*"([^"]+)"'
    if ($VersionMatch -and $VersionMatch.Matches.Groups.Count -gt 1) {
        $Version = $VersionMatch.Matches.Groups[1].Value
        Write-Host "    Detected version from init.lua: v$Version" -ForegroundColor Green
    } else {
        $Version = "2.1.0"
        Write-Host "    Version not found in init.lua, defaulting to: v$Version" -ForegroundColor Yellow
    }
} else {
    Write-Host "    Using user-specified version: v$Version" -ForegroundColor Green
}

# 2. Verify source components
$RedsPath = Join-Path $ScriptDir "r6\scripts\ForeverSandy.reds"
if (-not (Test-Path $RedsPath)) {
    Write-Error "Missing required script at '$RedsPath'."
    exit 1
}

# 3. Setup dist directory
$DistDir = Join-Path $ScriptDir "dist"
if (-not (Test-Path $DistDir)) {
    New-Item -ItemType Directory -Path $DistDir | Out-Null
}

$ZipName = "ForeverSandy-v$Version.zip"
$ZipPath = Join-Path $DistDir $ZipName

if (Test-Path $ZipPath) {
    Remove-Item $ZipPath -Force
    Write-Host "    Removed existing build: $ZipName" -ForegroundColor Gray
}

# 4. Create clean staging directory
$StageDir = Join-Path $DistDir "_staging"
if (Test-Path $StageDir) {
    Remove-Item $StageDir -Recurse -Force
}
New-Item -ItemType Directory -Path $StageDir | Out-Null

$StageBin = Join-Path $StageDir "bin\x64\plugins\cyber_engine_tweaks\mods\ForeverSandy"
$StageR6 = Join-Path $StageDir "r6\scripts"

New-Item -ItemType Directory -Path $StageBin -Force | Out-Null
New-Item -ItemType Directory -Path $StageR6 -Force | Out-Null

# Copy only release files (exclude local settings or logs)
Copy-Item -Path $InitLuaPath -Destination (Join-Path $StageBin "init.lua") -Force
Copy-Item -Path $RedsPath -Destination (Join-Path $StageR6 "ForeverSandy.reds") -Force

# 5. Build Zip Archive
Write-Host "    Compressing release archive..." -ForegroundColor Gray
Compress-Archive -Path (Join-Path $StageDir "*") -DestinationPath $ZipPath -CompressionLevel Optimal

# Cleanup staging
Remove-Item $StageDir -Recurse -Force

# 6. Summary
$ZipInfo = Get-Item $ZipPath
$SizeKb = [math]::Round($ZipInfo.Length / 1KB, 2)
Write-Host "==> Packaging complete!" -ForegroundColor Green
Write-Host "    Archive: $ZipPath" -ForegroundColor White
Write-Host "    Size:    $SizeKb KB" -ForegroundColor White
