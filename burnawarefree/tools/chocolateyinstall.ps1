$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.burnaware.com/downloads/burnaware_cfree_11.8.exe' # download url, HTTPS preferred

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  url64bit      = $url

  softwareName  = 'BurnAware Free*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = '3C9303E92B50722813CD87D46D55C8A3E171DBE0B5B96CF640D76DBBD83BD848'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '3C9303E92B50722813CD87D46D55C8A3E171DBE0B5B96CF640D76DBBD83BD848'
  checksumType64= 'sha256' #default is checksumType

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)

}

Install-ChocolateyPackage @packageArgs