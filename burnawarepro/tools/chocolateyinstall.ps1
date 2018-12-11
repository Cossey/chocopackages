$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.burnaware.com/downloads/burnaware_pro_11.8.exe' # download url, HTTPS preferred

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  url64bit      = $url

  softwareName  = 'BurnAware Free*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = 'EE8F3A8E7C28959D5B73FAC2D50418DC41AD0466EE285603835C9372D8C0AA0E'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = 'EE8F3A8E7C28959D5B73FAC2D50418DC41AD0466EE285603835C9372D8C0AA0E'
  checksumType64= 'sha256' #default is checksumType

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)

}

Install-ChocolateyPackage @packageArgs