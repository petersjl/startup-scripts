Import-Module Dotenv
Enable-Dotenv
Function prompt {
    if(Test-Path function:/Update-Dotenv) { Dotenv\Update-Dotenv }
    $currentDrive = $pwd.drive.name
    $currentFolder = Split-Path -path $pwd -Leaf
    try {
        $gitdir = Split-Path -Path $(git rev-parse --show-toplevel) -Leaf
    }catch{
        $gitdir = ""
    }
    Write-Host "[$currentDrive`:]" -ForegroundColor DarkGreen -NoNewline
    if($gitdir -ne  "") {
        Write-Host " $gitdir`:$(git branch --show-current)" -ForegroundColor Magenta -NoNewline
    }
    if ($gitdir -ne $currentFolder){
        Write-Host " $currentFolder" -ForegroundColor DarkCyan -NoNewline
    }
    return "> "
}

new-alias -Name np -Value notepad
# --General functions
Function prof { code $PROFILE }
function refreshpath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") +
                ";" +
                [System.Environment]::GetEnvironmentVariable("Path","User")
}
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
Function which {
    param ($command)
    (Get-Command $command).Path
}
Function la {
    Get-ChildItem -Force
}

# --Git
Function gph { git push $Args }
Function gpl { git pull $Args }
Function gf { git fetch $Args }
Function gs { git status $Args }
Function gas { git add * $Args }
Remove-Alias -Name gc -Force
Function gc {git checkout @Args }
Remove-Alias -Name gcb -Force
Function gcp {
    param ([string]$branch);
    gc $branch;
    gpl;
}
Function gcb { git checkout -b @Args }
Remove-Alias -Name gcm -Force
Function gcm { git commit -m @Args }
Function gcam {git add * && git commit -m @Args}
Function gbclean {
    param([string[]] $ignore = @())
    $ignore += @("dev", "qa", "prod", "main")
    $branches = git branch --merged
    foreach ($branch in $branches) {
        if ($branch -match '\*') { continue }
        if ($ignore -match $branch.Trim()) { continue }
        git branch -d $branch.Trim()
    }
}
Function glist { git branch --list }

# --Docker
$defaultProfile = 'local'
Function dockerstop { docker stop $(docker ps -a -q) }
# Connect to postgress. Replace variables before use
# Function dpsql {docker exec -e PGPASSWORD=<password> -it $(docker ps -q) psql -U <database-user> -d <database-name>}

# --Python
Function pm { python -m $Args }
Function pt { 
    param(
        [string] $filepath = '.',
        [parameter(position = 1, ValueFromRemainingArguments=$true)] $Remaining
    )
    python -m pytest $filepath $Remaining
}
