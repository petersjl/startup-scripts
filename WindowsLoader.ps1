# install new powershell
winget install --id Microsoft.Powershell --source winget

# run install script in new powershell
powershell -Command "& 'C:\Program Files\PowerShell\7\pwsh.exe' .\WindowsFiles\install.ps1"