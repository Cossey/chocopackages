$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.burnaware.com/downloads/burnaware_pro_11.8.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url

  softwareName  = 'BurnAware Professional*'

  checksum      = 'EE8F3A8E7C28959D5B73FAC2D50418DC41AD0466EE285603835C9372D8C0AA0E'
  checksumType  = 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)

}

Install-ChocolateyPackage @packageArgs