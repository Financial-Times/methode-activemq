# Write metrics to CloudWatch
#
#
#
# USAGE: ./cloudwatch_put.ps1 -value [integer] -namespace "com.ft.editorial.cms.printpreview.test" -region [eu-west-1/us-east-1/etc]
#
# PREREQUISITES
#
#  Script requires  _AWS Tools for Powershell_, see https://aws.amazon.com/powershell/ for details

# Process optional command line arguments
param (
   [string]$value = 1,
   [string]$namespace = "com.ft.editorial.cms.printpreview.test",
   [string]$region = "eu-west-1"
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


function putMetricData () {
  # http://docs.aws.amazon.com/powershell/latest/reference/Index.html
  # Write-CWMetricData -Namespace <String> -MetricData <MetricDatum[]> -PassThru <SwitchParameter> -Force <SwitchParameter>
  $dat = New-Object Amazon.CloudWatch.Model.MetricDatum
  $dat.Timestamp = (Get-Date).ToUniversalTime()
  $dat.Unit = "Count"
  $dat.MetricName = "methode-prime-running-on-$env:computername"
  $dat.Value = $value
  Set-DefaultAWSRegion -Region $region
  Write-CWMetricData -Namespace $namespace -MetricData $dat
  Write-Host "Sent value $value to namespace $namespace, exit code $LASTEXITCODE"
}

putMetricData
