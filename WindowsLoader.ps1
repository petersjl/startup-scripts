$profile_location = ".\WindowsFiles\profile.ps1"
$modules_location = ".\WindowsFiles\Modules"

# Install the profile
if(Test-Path $profile_location -PathType Leaf){
    New-Item $PROFILE -ItemType File -Force 1> $null
    Copy-Item $profile_location $PROFILE 1> $null
}
else {
    Write-Output "Could not find $profile_location"
}

# Install any modules in ./WindowsFiles/Modules
if(Test-Path $modules_location -PathType Container) {
    $module_destination = $env:PSModulePath.Split(";")[0]
    New-Item $module_destination -ItemType Directory -Force 1> $null
    Copy-Item -Path "$modules_location\*" -Destination $module_destination -Recurse
    Unblock-File -Path "$module_destination\*"
}