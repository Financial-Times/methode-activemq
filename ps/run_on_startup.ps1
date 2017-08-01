# A wrapper script that pulls the latest codebase from Git and start Prime Server

$cwd = $PSScriptRoot
Write-Host "Script directory is $cwd"
cd $cwd
$(git pull)
./start-prime.ps1
