new-alias -Name np -Value notepad
# General functions
Function prof { np $PROFILE }
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

Function hide-conf {
	git update-index --skip-worktree #relative path to file to ignore
}

Function show-conf {
	git update-index --no-skip-worktree #relative path to file to ignore
}

# Docker
<#
Function dockerstop { docker stop $(docker ps -a -q) }
Function dcud { docker compose up -d}
Function dcubd {docker compose up --build -d}
#>