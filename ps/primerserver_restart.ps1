# Script that starts/restarts Methode Prime client
#
# USAGE: ./ps/prime-server-restart.ps1
#
# PREREQUISITES
#
#  Script requires  _AWS Tools for Powershell_, see https://aws.amazon.com/powershell/ for details

$name = "Methode"
$sleep = 5
$cwd = $PSScriptRoot
. ${cwd}/aws.ps1
. ${cwd}/functions.ps1

$rvalue = checkProcess $name
if ( $rvalue ) {
  Write-Host "Restarting $name"
  Stop-Process -Name $name -Force
  Start-Sleep -s $sleep
  . ${cwd}/start-prime.ps1
}
else {
  Write-Host "$name is not running, starting"
  & "C:\Program Files\EidosMedia\Methode\bin\Methode.exe" -server=printpreview1
}
