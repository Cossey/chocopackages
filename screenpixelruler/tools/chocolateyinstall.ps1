$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$target = Join-Path $toolsDir "ScreenPixelRuler.exe"
Install-ChocolateyShortcut -shortcutFilePath "$([Environment]::GetFolderPath('CommonStartMenu'))\Programs\Screen Pixel Ruler.lnk" -targetPath "$target" -description "A pixel perfect on screen ruler."


