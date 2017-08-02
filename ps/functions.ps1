$hostname = $(hostname)
if ( $hostname.Substring(0,2) -eq "FT" ) {
  # Set dev flag false
  $dev = $FALSE
}
else {
  $dev = $TRUE
}

function checkProcess($name) {
  $running = $(get-process $name ; echo $?)
  return $running
}

function error([string]$message) {
  Write-Host "$message" -foreground "Red"
  if ( ! $dev ) {
    EventCreate /t Error /id 69 /l Application /so primeserver /d "$message"
  }
}

function errorAndExit([string]$message, [int]$code) {
  Write-Host "$message. Exit $code" -foreground "Red"
  if ( ! $dev ) {
    EventCreate /t Error /id 69 /l Application /so primeserver /d "$message"
  }
  exit $code
}

function info([string]$message) {
  Write-Host "$message" -foreground "Green"
  if ( ! $dev ) {
    EventCreate /t Information /id 69 /l Application /so primeserver /d "$message"
  }
}
