$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.burnaware.com/downloads/burnaware_cfree_11.9.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url

  softwareName  = 'BurnAware Free*'

  checksum      = '4DB16B8FD6A1AB9736EFBB02A07EAF4C03A7669D6526359C1D55F44C3134D6BC'
  checksumType  = 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)

}

Install-ChocolateyPackage @packageArgs