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

$ft_env = "test"
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
  $primecfg = "/repo/cfg/primeServer.cfg"
}
else {
  Write-Host "Windows Machine"
  $primecfg = "C:\Program Files\EidosMedia\Methode\cfg\primeServer.cfg"
}

# Set ActiveMQ hostname in primeServer.cfg
if ($(Test-path $primecfg) -eq $True) {
  info "Found config file $primecfg"
  gc $primecfg | %{ $_ -replace "binary.staging.methode.(.*).internal.ft.com", "binary.staging.methode.${ft_env}.internal.ft.com" } | Set-Content $primecfg
}
else {
  info "$primecfg not found"
}

if ( ! $dev) {
  # IMPORT AWS POWERSHELL MODULE AND READ REDENTIALS
  loadAwsPsModule

  # START PRIME CLIENT IN SERVER MODE
  & "C:\Program Files\EidosMedia\Methode\bin\Methode.exe" -server=printpreview1
}
else {
  info "Skipping Methode Prime startup"
}
