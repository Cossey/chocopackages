$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.acarda.com/downloads/acardaoutbound/AcardaOutboundSoloSetup-7.3.0.2684.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url

  softwareName  = 'Acarda Outbound Solo Editon' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = '063613C772CD52FFB23BF930E44A6133DFA1FAD835C8D6017C1E0501A305B8F3'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '063613C772CD52FFB23BF930E44A6133DFA1FAD835C8D6017C1E0501A305B8F3'
  checksumType64= 'sha256' #default is checksumType
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs