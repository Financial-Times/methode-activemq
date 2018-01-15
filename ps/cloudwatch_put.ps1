# Write metrics to CloudWatch
#
#
#
# USAGE: ./cloudwatch_put.ps1 -value [integer] -namespace "com.ft.editorial.cms.printpreview.test"
#
# PREREQUISITES
#
#  Script requires  _AWS Tools for Powershell_, see https://aws.amazon.com/powershell/ for details

# Process optional command line arguments
param (
   [string]$value = 1,
   [string]$namespace = "com.ft.editorial.cms.printpreview.test"
)

# IMPORT AWS POWERSHELL MODULE AND CREDENTIALS
try {
  $aws_module = 'C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell\AWSPowerShell.psd1'
  Write-Host "Load AWS module"
  Import-Module -Name $aws_module
  Write-Host "AWS module loaded"
}
catch {
  Write-Host "Failed to load AWS Powershell module"
}


function putMetricData ($input) {
  # http://docs.aws.amazon.com/powershell/latest/reference/Index.html
  # Write-CWMetricData -Namespace <String> -MetricData <MetricDatum[]> -PassThru <SwitchParameter> -Force <SwitchParameter>
  $dat = New-Object Amazon.CloudWatch.Model.MetricDatum
  $dat.Timestamp = (Get-Date).ToUniversalTime()
  $dat.Unit = "Count"
  $dat.MetricName = "methode-prime-running-on-$env:computername"
  $dat.Value = $input
  Write-CWMetricData -Namespace $namespace -MetricData $dat
  Write-Host "Sent value $input to namespace $namespace"
}

putMetricData $value
