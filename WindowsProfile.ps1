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

Function test {
	if (!(Test-Path ./.git -PathType Container)) {
		Write-Output "Current directory is not a git repository"
		return
	} 
	
	
}

Function add-conf {
	param($add_file)
	if ($null -eq $add_file) {
		Write-Output "Usage: add-conf [relative path to configuration file]"
		return
	}
	if (!(Test-Path ./.git -PathType Container)) {
		Write-Output "Current directory is not a git repository"
		return
	}
	$conf_file = "$pwd\.configfiles"
	if (!(Test-Path ./.configfiles -PathType Leaf)) {
		Out-File -FilePath $conf_file -Width 2000 -InputObject ".configfiles"
	}
	$contents = Get-Content -Path $conf_file
	ForEach ($file in $contents) {
		if ($file -eq $add_file) {
			Write-Output "File '$add_file' is already added"
			return 
		}
	}
	Out-File -FilePath $conf_file -Width 2000 -Append -InputObject $add_file
}

# Docker
<#
Function dockerstop { docker stop $(docker ps -a -q) }
Function dcud { docker compose up -d}
Function dcubd {docker compose up --build -d}
#>