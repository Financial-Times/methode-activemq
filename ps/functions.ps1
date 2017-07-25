function errorAndExit([string]$message, [int]$code) {
  Write-Host "$message. Exit $code" -foreground "Red"
  exit $code
}
