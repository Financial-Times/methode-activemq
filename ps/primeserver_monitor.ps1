# Check whether Methode Prime Server is running and if not start it
#
# USAGE: ./ps/primeserver_monitor.ps1
#
# PREREQUISITES
#
#  Script requires  _AWS Tools for Powershell_, see https://aws.amazon.com/powershell/ for details

$sleep = 10
$name = "Methode"
$cwd = $PSScriptRoot
. ${cwd}/aws.ps1
. ${cwd}/functions.ps1

$rvalue = checkProcess $name
if ( $rvalue ) {
  info "Process $name is running"
  exit 0
}
else {
  info "Process $name is not running. Starting instance."
  . ${cwd}/start-prime.ps1
  Start-Sleep -s $sleep
}
$rvalue = checkProcess $name
if ( $rvalue ) {
  info "Process $name is running"
}
else {
  error "Process $name is not running. Giving up."
}
