
# bootstrap DNVM into this session.
&{$Branch='dev';iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.ps1'))}

# load up the global.json so we can find the DNX version
$globalJson = Get-Content -Path $PSScriptRoot\global.json -Raw | ConvertFrom-Json
$dnxVersion = $globalJson.sdk.version

# install DNX
& $env:USERPROFILE\.dnx\bin\dnvm install $dnxVersion -Persistent

# run DNU restore on all project.json files in the src folder
Get-ChildItem -Path $PSScriptRoot\src -Filter project.json -Recurse | ForEach-Object { & dnu restore $_.FullName }
