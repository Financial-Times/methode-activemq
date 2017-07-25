function loadAwsPsModule() {
  try {
    $aws_module = 'C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell\AWSPowerShell.psd1'
    Write-Host 'Loading AWS module'
    Import-Module -Name $aws_module -ErrorAction Stop
    Write-Host 'AWS module loaded'
    Write-Host 'Validating AWS credentials'
    $aws_credentials = 'c:\tools\credentials'
    $file_exist = Test-Path $aws_credentials
    if ( !$file_exist ) {
      errorAndExit "Failed to validate AWS credentials $aws_credentials." 1
    }
  }
  catch {
    Write-Host "Failed to load AWS Powershell module"
  }
}
