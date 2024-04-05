New-Item $PROFILE -ItemType File -Force 1> $null
Copy-Item .\WindowsProfile.ps1 $PROFILE 1> $null