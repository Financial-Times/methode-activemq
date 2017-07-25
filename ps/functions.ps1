function error([string]$message) {
  Write-Host "$message." -foreground "Red"
}

function errorAndExit([string]$message, [int]$code) {
  Write-Host "$message. Exit $code" -foreground "Red"
  exit $code
}
