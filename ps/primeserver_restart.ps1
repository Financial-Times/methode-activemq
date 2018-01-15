# Script that starts/restarts Methode Prime client
#
# USAGE: ./ps/primeserver_restart.ps1
#
# PREREQUISITES
#
#  Script requires  _AWS Tools for Powershell_, see https://aws.amazon.com/powershell/ for details


# Process optional command line arguments
param (
   [string]$namespace = "com.ft.editorial.cms.printpreview.test",
   [string]$region = "eu-west-1"
)

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

Start-Sleep -s $sleep
$rvalue = checkProcess $name
if ( $rvalue ) {
  . ${cwd}/cloudwatch_put.ps1 -value 1 -namespace "$namespace"
}
else {
  . ${cwd}/cloudwatch_put.ps1 -value 0 -namespace "$namespace"
}
