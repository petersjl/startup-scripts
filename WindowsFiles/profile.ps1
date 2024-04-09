new-alias -Name np -Value notepad
# General functions
Function prof { code $PROFILE }
Function w {wsl ~}
Function e {explorer .}
Function c {
    param ($filepath)
    if ($null -eq $filepath) {
        code .
    }
    else {
        code $filepath
    }
}

# Git
Function gph { git push }
Function gpl { git pull }
Function gf { git fetch }

# Docker
<#
Function dockerstop { docker stop $(docker ps -a -q) }
Function dcud { docker compose up -d}
Function dcubd {docker compose up --build -d}
#>