function Install-SysinternalsSuite {
    param(
        [string]$Destination = "C:\Tools\Sysinternals",
        [switch]$Overwrite,
        [switch]$KeepZip
        [switch]$NoInstall
    )

    $url = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
    
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $zipPath = Join-Path $env:TEMP "SysinternalsSuite-$timestamp.zip"
    
    if ((Test-Path $Destination) -and -not $Overwrite) {
        Write-Host "Destination already exists: $Destination"
        Write-Host "Use -Overwrite to replace it."
        return
    }

    if ($Overwrite -and (Test-Path $Destination)) {
        Remove-Item $Destination -Recurse -Force
    }

    New-Item -ItemType Directory -Path $Destination -Force | Out-Null

    Write-Host "Downloading Sysinternals Suite..."
    Invoke-WebRequest -Uri $url -OutFile $zipPath
    Write-Host "Sysinternals Suite Downloaded to: $zipPath"
    
    if (-not $NoInstall) {
        Write-Host "Extracting to $Destination..."
        Expand-Archive -Path $zipPath -DestinationPath $Destination -Force

        if (-not $KeepZip) {
            Remove-Item $zipPath -Force
        }

        Write-Host "Sysinternals Suite installed to: $Destination"
    }
}

Install-SysinternalsSuite -Destination "C:\Tools\Sysinternals" -Overwrite
