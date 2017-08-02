# Script that looks for process name and returns 1 if running or 0 if not running
#
# USAGE: ./ps/check_proces.ps1 -name "Powershell"
#
# PREREQUISITES
#
#  Script requires  _AWS Tools for Powershell_, see https://aws.amazon.com/powershell/ for details
# Process optional command line arguments
param (
   [string]$name
)

$cwd = $PSScriptRoot
. ${cwd}/aws.ps1
. ${cwd}/functions.ps1

$rvalue = checkProcess $name
if ( $rvalue ) {
  Write-Host "Process $name is running"
}
else {
  Write-Host "Process $name is not running"
}
