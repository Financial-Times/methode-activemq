function error([string]$message) {
  Write-Host "$message" -foreground "Red"
  EventCreate /t Error /id 69 /l Application /so start-prime /d "$message"
}

function errorAndExit([string]$message, [int]$code) {
  Write-Host "$message. Exit $code" -foreground "Red"
  EventCreate /t Error /id 69 /l Application /so start-prime /d "$message"
  exit $code
}

function info([string]$message) {
  Write-Host "$message" -foreground "Blue"
  EventCreate /t Information /id 69 /l Application /so start-prime /d "$message"
}
