$CONF_FILE = "./.configfiles"
$NOT_INITIALIZED = "No config files defined. Run 'conf add <files...>' first"

function conf (
        [Parameter(Mandatory=$true, Position=0)][ValidateSet('show', 'hide', 'add', 'remove', 'list')][string]$Command,
        [Parameter(ValueFromRemainingArguments=$true)][string[]]$Files
        ) 
{
    # Make sure we're in a git repository
    if (!(Test-Path ./.git -PathType Container)) {
        Write-Output "Current directory is not a git repository root directory"
        return
    } 

    switch ($Command) {
        "show" { show }
        "hide" { hide }
        "add" { add($Files) }
        "remove" { remove($Files) }
        "list" { list }
        Default {}
    }
}

function show {
    if(!(test-conf-file)) {
        Write-Output $NOT_INITIALIZED
        return
    }

    $contents = Get-Content -Path $CONF_FILE
	ForEach ($file in $contents) {
		git update-index --no-skip-worktree $file
	}
}

function hide {
    if(!(test-conf-file)) {
        Write-Output $NOT_INITIALIZED
        return
    }

    $contents = Get-Content -Path $CONF_FILE
	ForEach ($file in $contents) {
		git update-index --skip-worktree $file
	}
}

function add([string[]]$Files) {
    if (($null -eq $Files) -OR ($Files.Count -eq 0)) {
        Write-Output "Usage: conf add <files...>"
        return
    }
    if(!(test-conf-file)) {
        $(New-Item -Path $CONF_FILE -Type File) 1>$null
        Write-Output "Created '.configfiles'. You may want to add this to your '.gitignore'"
    }
    $contents = Get-Content -Path $CONF_FILE
    ForEach ($add_file in $Files) {
        # Ensure the new file isn't already added
        $added = $false
        ForEach ($file in $contents) {
            if ($file -eq $add_file) {
                $added = $true
                break
            }
        }
        # Add the file to the list
        if (!$added) {Out-File -FilePath $CONF_FILE -Width 2000 -Append -InputObject $add_file}
    }
}

function remove([string[]]$Files) {
    if (($null -eq $Files) -OR ($Files.Count -eq 0)) {
        Write-Output "Usage: conf remove <files...>"
        return
    }
    if(!(test-conf-file)) {
        Write-Output "No files have been configured"
        return
    }
    $contents = [System.Collections.ArrayList]@(Get-Content -Path $CONF_FILE)
    $modified = $false
    ForEach ($rem_file in $Files) {
        For ($i = 0; $i -lt $contents.Count; $i++) {
            if ($rem_file -eq $contents[$i]) {
                $contents.RemoveAt($i)
                $modified = $true
                break
            }
        }
    }
    if ($modified) {Out-File -FilePath $CONF_FILE -Width 2000 -InputObject $contents}
}

function list {
    if(!(test-conf-file)) {
        Write-Output "No files have been configured"
        return
    }
    $contents = Get-Content -Path $CONF_FILE
    Write-Output $contents
}

function test-conf-file() {
	Test-Path $CONF_FILE -PathType Leaf
}

Export-ModuleMember -Function conf