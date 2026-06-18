# Chocolatey - lazy load on first use (avoids slow module import at startup)
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path $ChocolateyProfile) {
    $script:_chocoProfile = $ChocolateyProfile
    function global:choco {
        Remove-Item Function:\choco -Force -ErrorAction SilentlyContinue
        Import-Module $script:_chocoProfile
        & "$env:ChocolateyInstall\choco.exe" @args
    }
}

function makevideo($inputFile, $outputFile, $framerate = 25, $start = 1) {
  # Uses ffmpeg directly
  ffmpeg -framerate $framerate -start_number $start -i "$inputFile" -c:v libx264 -pix_fmt yuv420p "$outputFile"
}

# YAZI START
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}
# YAZI END

function makewebp($inputFile, $outputFile) {
  ffmpeg -i "$inputFile" -loop 1 -an -vf fps=fps=25 "$outputFile"
}

function joinvideos {
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromRemainingArguments=$true)]
        [string[]]$videos,
        [Parameter(Mandatory=$false)]
        [string]$output = "output.mp4"
    )

    # Build the argument list properly
    $argList = @()
    foreach ($video in $videos) {
        $argList += $video
    }
    $argList += "--output"
    $argList += $output

    # Call python with the properly separated arguments
    & python "d:\Code\lv-helpers\joinvideos.py" $argList
}

# aliases
function notes {
    z db
    nvim
}

function zvim {
    param(
      [Parameter(Mandatory=$true)]
      [string]$dir
    )
    if ($dir) {
        z $dir
    }
    nvim
}

function vim(){
  $env:NVIM_APPNAME = "nvim-clean"
  nvim $args
}

function q {
    exit
}

function sound { yt-dlp --extract-audio --audio-format mp3 @args }

function lvclone {
    param(
      [Parameter(Mandatory=$true)]
      [string]$repo
    )
    git clone https://github.com/lukevanlukevan/$repo.git
  }

$zoxCache = "$env:LOCALAPPDATA\zoxide-init-cache.ps1"
if (-not (Test-Path $zoxCache)) {
    zoxide init powershell | Out-File $zoxCache -Encoding UTF8
}
. $zoxCache
oh-my-posh init pwsh --config 'C:\Users\PIC-TWO\AppData\Local\omp-manager\themes\larserikfinholt.omp.json' | Invoke-Expression  # [omp-manager]
