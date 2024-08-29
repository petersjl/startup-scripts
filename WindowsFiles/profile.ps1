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

# --Git
Function gph { git push $Args }
Function gpl { git pull $Args }
Function gf { git fetch $Args }
Function gs { git status $Args }
Function gas { git add * $Args }
Function gcm { git commit -m $Args }

# --Docker
$defaultProfile = 'local'
Function dockerstop { docker stop $(docker ps -a -q) }
Function dcud {
    param(
        [parameter(position = 0)] [string] $profile = $defaultProfile,
        [parameter(position = 1, ValueFromRemainingArguments=$true)] $Remaining
    )
    docker compose --profile $profile up -d
}
Function dcub {
    param(
        [parameter(position = 0)] [string] $profile = $defaultProfile,
        [parameter(position = 1, ValueFromRemainingArguments=$true)] $Remaining
    )
    docker compose --profile $profile up --build
}
Function dcubd {
    param(
        [parameter(position = 0)] [string] $profile = $defaultProfile,
        [parameter(position = 1, ValueFromRemainingArguments=$true)] $Remaining
    )
    docker compose --profile $profile up --build -d
}
Function dcubw {
    param(
        [parameter(position = 0)] [string] $profile = $defaultProfile,
        [parameter(position = 1, ValueFromRemainingArguments=$true)] $Remaining
    )
    docker compose --profile $profile up --build --watch
}
Function dcdv {
    param(
        [parameter(position = 0)] [string] $profile = $defaultProfile,
        [parameter(position = 1, ValueFromRemainingArguments=$true)] $Remaining
    )
    docker compose --profile $profile down --volumes @Remaining 
}
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
