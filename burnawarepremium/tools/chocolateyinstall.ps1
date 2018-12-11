$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.burnaware.com/downloads/burnaware_premium_11.8.exe' # download url, HTTPS preferred

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  url64bit      = $url

  softwareName  = 'BurnAware Free*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = '77674FF4E3FE1CAC5500932BF2D799CA803D5DC7246FE05ADA6A4EF1BC60060B'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '77674FF4E3FE1CAC5500932BF2D799CA803D5DC7246FE05ADA6A4EF1BC60060B'
  checksumType64= 'sha256' #default is checksumType

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)

}

Install-ChocolateyPackage @packageArgs