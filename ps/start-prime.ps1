# Starts Prime Client
#
# USAGE: ./start-prime.ps1 -namespace "com.ft.edtech.methode.prod"
#
# PREREQUISITES
#
#  Script requires  _AWS Tools for Powershell_, see https://aws.amazon.com/powershell/ for details
# Process optional command line arguments
param (
   [string]$namespace = "com.ft.edtech.methode.prod"
)

$cwd = $PSScriptRoot
. ${cwd}/aws.ps1
. ${cwd}/functions.ps1

$hostname = $(hostname)
if ( $hostname.Substring(0,2) -eq "FT" ) {
  $dev = $FALSE
}
else {
  $dev = $TRUE
}
if ( $dev ) {
  Write-Host "Dev machine"
}
else {
  Write-Host "Windows Machine"
}

# IMPORT AWS POWERSHELL MODULE AND READ REDENTIALS
loadAwsPsModule

# START PRIME CLIENT IN SERVER MODE
& "C:\Program Files\EidosMedia\Methode\bin\Methode.exe" -server=printpreview1
