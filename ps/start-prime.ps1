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

if ( $dev ) {
  info "Dev machine"
  $primecfg = "/repo/cfg/primeServer.cfg"
  $amq_env = "int"
}
else {
  info "Windows Machine"
  $primecfg = "C:\Program Files\EidosMedia\Methode\cfg\primeServer.cfg"

  # Set environment for AMQ endpoint based on 2 last characters of hostname
  $last_two = $hostname.Substring($hostname.Length - 2)
  switch ($last_two) {
    '-p' { $amq_env = "test" }
    '-t' { $amq_env = "test" }
    'nt' { $amq_env = "test" }
  }
}

# Set ActiveMQ hostname in primeServer.cfg
if ($(Test-path $primecfg) -eq $True) {
  info "Found config file $primecfg"
  info "Configuring endpoint binary.staging.methode.${amq_env}.internal.ft.com"
  gc $primecfg | %{ $_ -replace "binary.staging.methode.(.*).internal.ft.com", "binary.staging.methode.${amq_env}.internal.ft.com" } | Set-Content primecfg.tmp
  gc primecfg.tmp | Set-Content $primecfg
  Remove-Item primecfg.tmp
}
else {
  info "$primecfg not found"
}

if ( ! $dev) {
  # IMPORT AWS POWERSHELL MODULE AND READ REDENTIALS
  info "Load AWS PowerShell module"
  loadAwsPsModule

  # START PRIME CLIENT IN SERVER MODE
  info "Start Methode Prime Server"
  & "C:\Program Files\EidosMedia\Methode\bin\Methode.exe" -server=printpreview1
}
else {
  info "Skipping Methode Prime startup"
}
info "Script execution finished"
