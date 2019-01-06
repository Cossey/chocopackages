$version = Read-Host -Prompt 'Enter version number'
$url = "https://www.burnaware.com/downloads/burnaware_pro_$version.exe"
$whatsnewurl = "www.burnaware.com/whats-new.html"
$outfile = ".\temp\pro_$version"
Invoke-WebRequest -Uri $url -outfile $outfile
$filehash = (Get-FileHash $outfile).Hash
Write-Host "File hash is $filehash"
Remove-Item �path $outfile
Write-Host "Getting changelog info..."
$whatsnew = Invoke-WebRequest -Uri $whatsnewurl 

$releasedate = [regex]::match($whatsnew.Content, "Released (.*)<br />").Groups[1].Value

$newfeatures = [regex]::match($whatsnew.Content, "New Features </span>(.*?)</p>", [Text.RegularExpressions.RegexOptions]::Singleline).Groups[1].Value
$newfeatures = $newfeatures -replace " &#8226;", "*"
$newfeatures = $newfeatures -replace "<br />", ""
$newfeatures = $newfeatures -replace "<br/>", ""

$enhancements = [regex]::match($whatsnew.Content, "Enhancements </span>(.*?)</p>", [Text.RegularExpressions.RegexOptions]::Singleline).Groups[1].Value
$enhancements = $enhancements -replace " &#8226;", "*"
$enhancements = $enhancements -replace "<br />", ""
$enhancements = $enhancements -replace "<br/>", ""

$bugfixes = [regex]::match($whatsnew.Content, "Bug Fixes </span>(.*?)</p>", [Text.RegularExpressions.RegexOptions]::Singleline).Groups[1].Value
$bugfixes = $bugfixes -replace " &#8226;", "*"
$bugfixes = $bugfixes -replace "<br />", ""
$bugfixes = $bugfixes -replace "<br/>", ""
Write-Host "Release date $releasedate"


Write-Host "Processing install file..."
$citemplate = Get-Content ".\templates\burnawarepro\chocolateyInstall.ps1.template" -raw

$citemplate = $citemplate -replace "%hash%", "$filehash"
$citemplate = $citemplate -replace "%downloadurl%", "$url"

$citemplate | Out-File ".\burnawarepro\tools\chocolateyInstall.ps1"

Write-Host "Processing nuspec file..."
$nstemplate = Get-Content ".\templates\burnawarepro\burnawarepro.nuspec.template" -raw
$nstemplate = $nstemplate -replace "%fileversion%", "$version"
$nstemplate = $nstemplate -replace "%releasedate%", "$releasedate"
$nstemplate = $nstemplate -replace "%newfeatures%", "$newfeatures"
$nstemplate = $nstemplate -replace "%enhancements%", "$enhancements"
$nstemplate = $nstemplate -replace "%bugfixes%", "$bugfixes"
$nstemplate | Out-File ".\burnawarepro\burnawarepro.nuspec"
cd .\burnawarepro
cpack
cpush
del *.$version.nupkg
cd ..