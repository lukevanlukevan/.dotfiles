oh-my-posh init pwsh --config 'C:\Users\PIC-TWO\AppData\Local\Programs\oh-my-posh\themes\takuya.omp.json' | Invoke-Expression
Invoke-Expression (& { (zoxide init powershell | Out-String) })
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# function makevideo($inputFile, $outputFile, $framerate = 25, $start = 1) {
#   ffmpeg -framerate $framerate  -start_number $start -i $inputFile -c:v libx264 -pix_fmt yuv420p $outputFile
# }

function makevideo($inputFile, $outputFile, $framerate = 25, $start = 1) {
    # Assuming you save the Python script at C:\Scripts\image_processor.py
    python d:\Code\lv-helpers\image2sequence.py $inputFile --framerate $framerate --start $start
}

function joinvideos {
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromRemainingArguments=$true)]
        [string[]]$videos,
        [Parameter(Mandatory=$false)]
        [string]$output = "output.mp4"
    )

    # Build the argument list properly
    $args = @()
    foreach ($video in $videos) {
        $args += $video
    }
    $args += "--output"
    $args += $output

    # Call python with the properly separated arguments
    & python "d:\Code\lv-helpers\joinvideos.py" $args
}

# aliases
function notes {
    z db
    nvim
}

