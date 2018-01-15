# Script that starts/restarts Methode Prime client
#
# USAGE: ./ps/primeserver_restart.ps1
#
# PREREQUISITES
#
#  Script requires  _AWS Tools for Powershell_, see https://aws.amazon.com/powershell/ for details

$name = "Methode"
$sleep = 5
$cwd = $PSScriptRoot
#. ${cwd}/aws.ps1
. ${cwd}/functions.ps1

function setNamespace () {
  # Set environment for AMQ endpoint based on 2 last characters of hostname
  $last_two = $hostname.Substring($hostname.Length - 2)
  switch ($last_two) {
    '-p' { $ft_env = "prod" }
    '-t' { $ft_env = "test" }
  }
  return "com.ft.editorial.cms.printpreview.$ft_env"
}

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
$namespace = setNamespace
Start-Sleep -s $sleep
$rvalue = checkProcess $name
if ( $rvalue ) {
  . ${cwd}/cloudwatch_put.ps1 -value 1 -namespace $namespace
}
else {
  . ${cwd}/cloudwatch_put.ps1 -value 0 -namespace $namespace
}
Start-Sleep -s $sleep