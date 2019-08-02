Write-Host "Building Chocolately Package for Acarda Outbound Solo..."

Write-Host "Create Folders..."
New-Item -Path . -Name "temp" -ItemType "directory" -ErrorAction Ignore
New-Item -Path . -Name "acardaoutboundsolo" -ItemType "directory" -ErrorAction Ignore
New-Item -Path .\acardaoutboundsolo -Name "tools" -ItemType "directory" -ErrorAction Ignore

$version = Read-Host -Prompt 'Enter Version No'
$url = "http://www.acarda.com/downloads/acardaoutbound/AcardaOutboundSoloSetup-" + $version + ".exe"

Write-Host "Download Link: $url"

Write-Host "Downloading file to get the filehash..."
$outfile = ".\temp\solo_$version"
Invoke-WebRequest -Uri $url -outfile $outfile
$filehash = (Get-FileHash $outfile).Hash
Write-Host "File hash: $filehash"
Remove-Item -path $outfile

Write-Host "Processing install file..."
$citemplate = Get-Content ".\templates\acardaoutboundsolo\chocolateyInstall.ps1.template" -raw

$citemplate = $citemplate -replace "%hash%", "$filehash"
$citemplate = $citemplate -replace "%downloadurl%", "$url"

$citemplate | Out-File ".\acardaoutboundsolo\tools\chocolateyInstall.ps1"

Write-Host "Processing nuspec file..."
$nstemplate = Get-Content ".\templates\acardaoutboundsolo\acardaoutboundsolo.nuspec.template" -raw
$nstemplate = $nstemplate -replace "%fileversion%", "$version"
$nstemplate | Out-File ".\acardaoutboundsolo\acardaoutboundsolo.nuspec"

Write-Host "Creating choco package..."
Set-Location -Path .\acardaoutboundsolo
cpack
Write-Host "Uploading choco package..."
cpush
Write-Host "Delete folder..."
Set-Location -Path ..
Remove-Item -path .\acardaoutboundsolo -recurse
Write-Host "Script completed"