$CONF_FILE = "./.git/configfiles"
$NOT_INITIALIZED = "No config files defined. Run 'conf add <files...>' first"

function conf (
        [Parameter(Position=0)][string]$Command,
        [Parameter(ValueFromRemainingArguments=$true)][string[]]$Files
        ) 
{
    # Make sure we're in a git repository
    if (!(Test-Path ./.git -PathType Container)) {
        Write-Output "Current directory is not a git repository root directory"
        return
    }

    if (!($Command)) {
        help("default")
        return
    }

    switch ($Command) {
        {$_ -in "show", "s"} { show }
        {$_ -in "hide", "h"} { hide }
        {$_ -in "add", "a"} { add($Files) }
        {$_ -in "remove", "r"} { remove($Files) }
        {$_ -in "list", "l"} { list }
        "help" {
            if (($null -eq $Files) -or ($Files.Count -lt 1)) {
                help
            } else {
                help($Files[0])
            }
        }
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
        help("add")
        return
    }
    if(!(test-conf-file)) {
        $(New-Item -Path $CONF_FILE -Type File) 1>$null
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
        help("remove")
        return
    }
    if(!(test-conf-file)) {
        Write-Output "No files have been configured"
        return
    }
    $contents = [System.Collections.ArrayList]@(Get-Content -Path $CONF_FILE)
    $modified = $false
    ForEach ($rem_file in $Files) {
        $removed = $false
        For ($i = 0; $i -lt $contents.Count; $i++) {
            if ($rem_file -eq $contents[$i]) {
                $contents.RemoveAt($i)
                $removed = $true
                $modified = $true
                break
            }
        }
        if(!($removed)) {
            Write-Output "File <$rem_file> not found in config index"
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
    if($contents.Count -lt 1) {
        Write-Output "No files have been configured"
    } else {
        Write-Output $contents
    }
}

function help ($Command) {
    switch ($Command) {
        {$_ -in "show", "s"} {
            Write-Output "`tShow all files in the config index"
            Write-Output "`tUsage: conf <show | s>"
        }
        {$_ -in "hide", "h"} {
            Write-Output "`tHide all files in the config index"
            Write-Output "`tUsage: conf <hide | h>"
        }
        {$_ -in "add", "a"} {
            Write-Output "`tAdd a file to the config index"
            Write-Output "`tUsage: conf <add | a> file1 [files...]"
        }
        {$_ -in "remove", "r"} {
            Write-Output "`tRemove a file from the config index"
            Write-Output "`tUsage: conf <remove | r> file1 [files...]"
        }
        {$_ -in "list", "l"} {
            Write-Output "`tList all files in the config index"
            Write-Output "`tUsage: conf <list | l>"
        }
        "default" {
            Write-Output "This program is used to track files that need to change`nbut you don't want to be shown in the git worktree as `nchanged (like config files)`n"
            Write-Output "Usage: conf <command> [<args>]`n"
            Write-Output "Commands:"
            Write-Output "`tshow | s`tShow all files in the config index"
            Write-Output "`thide | h`tHide all files in the config index"
            Write-Output "`tadd | a`t`tAdd a file to the config index"
            Write-Output "`tremove | r`tRemove a file from the config index"
            Write-Output "`tlist | l`tList all files in the config index"
            Write-Output "`thelp`t`tShow help for a given subcommand"
        }
        Default {
            Write-Output "`tShows help for a given subcommand"
            Write-Output "`tUsage: conf help <subcommand>"
        }
    }
    return
}

function test-conf-file() {
	Test-Path $CONF_FILE -PathType Leaf
}

Export-ModuleMember -Function conf