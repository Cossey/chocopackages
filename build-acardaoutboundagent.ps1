Write-Host "Building Chocolately Package for Acarda Outbound Agent..."

Write-Host "Create Folders..."
New-Item -Path . -Name "temp" -ItemType "directory" -ErrorAction Ignore
New-Item -Path . -Name "acardaoutboundagent" -ItemType "directory" -ErrorAction Ignore
New-Item -Path .\acardaoutboundagent -Name "tools" -ItemType "directory" -ErrorAction Ignore

$version = Read-Host -Prompt 'Enter Version No'
$url = "http://www.acarda.com/downloads/acardaoutbound/AcardaOutboundAgentSetup-" + $version + ".exe"

Write-Host "Download Link: $url"

Write-Host "Downloading file to get the filehash..."
$outfile = ".\temp\agent_$version"
Invoke-WebRequest -Uri $url -outfile $outfile
$filehash = (Get-FileHash $outfile).Hash
Write-Host "File hash: $filehash"
Remove-Item -path $outfile

Write-Host "Processing install file..."
$citemplate = Get-Content ".\templates\acardaoutboundagent\chocolateyInstall.ps1.template" -raw

$citemplate = $citemplate -replace "%hash%", "$filehash"
$citemplate = $citemplate -replace "%downloadurl%", "$url"

$citemplate | Out-File ".\acardaoutboundagent\tools\chocolateyInstall.ps1"

Write-Host "Processing nuspec file..."
$nstemplate = Get-Content ".\templates\acardaoutboundagent\acardaoutboundagent.nuspec.template" -raw
$nstemplate = $nstemplate -replace "%fileversion%", "$version"
$nstemplate | Out-File ".\acardaoutboundagent\acardaoutboundagent.nuspec"

Write-Host "Creating choco package..."
Set-Location -Path .\acardaoutboundagent
cpack
Write-Host "Uploading choco package..."
cpush
Write-Host "Delete folder..."
Set-Location -Path ..
Remove-Item -path .\acardaoutboundagent -recurse
Write-Host "Script completed"