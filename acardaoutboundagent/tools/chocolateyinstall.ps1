$ErrorActionPreference = 'Stop'; # stop on all errors

$pp = Get-PackageParameters

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.acarda.com/downloads/acardaoutbound/AcardaOutboundAgentSetup-7.3.0.2684.exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

if ($pp['server']) { 
Write-Host "Configure agent for server $($pp['server'])"
$silentArgs += " /server $($pp['server'])" 
}

if ($pp['port']) { 
Write-Host "Configure agent for port $($pp['port'])"
$silentArgs += " /port $($pp['port'])" 
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url

  softwareName  = 'Acarda Outbound Agent' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = '53946F77E87D8BD4B0F7BDEED514AF1DABDF7C8BFF076D314F75A738A9EF5160'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '53946F77E87D8BD4B0F7BDEED514AF1DABDF7C8BFF076D314F75A738A9EF5160'
  checksumType64= 'sha256' #default is checksumType
  silentArgs   = $silentArgs
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs