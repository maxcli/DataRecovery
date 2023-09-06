# D:\FileRecovery\scanhd.ps1
# 
#
# to run. Powershell command :  .\scanhd.ps1
#



$drive="e:\"
$magicWord1 = "windows"
$magicWord2 = "microsoft"
$magicWord3 = "program files"
$magicWord4="BackupData"
$magicWord5="WindowsApps"
$magicWord6="SteamLibrary"
$magicWord7="games"


$codePath="D:\FileRecovery\"
$tempPath="D:\FileRecovery\tmp\"

############################################
try{

    

    Remove-Item  $tempPath -Force  -Recurse -ErrorAction SilentlyContinue
    New-Item -Path $codePath -Name "tmp" -ItemType "directory"


    $files=   Get-ChildItem  $drive    -include ('*.wav','*.doc', '*.docx', '*.mp4', '*.pic', '*.jpg', '*.bmp'  , '*.avi', '*.mp3', '*.mpg', '*.wmv'    ) -recurse


    Write-Host ("Number of entries found:"+ $files.length)
    Write-Host "after" 

    foreach ($file in $files)
    {
    
        try{
            if($file.FullName -match $magicWord1  -or $file.FullName -match $magicWord2 -or $file.FullName -match $magicWord3 -or $file.FullName -match $magicWord4 -or $file.FullName -match $magicWord5 -or $file.FullName -match $magicWord6 -or $file.FullName -match $magicWord7)
            {
                #Write-Output ("Exclude :" + $file.FullName)
                continue
            }

            Write-Output ("Include file name:" + $file.FullName)
            Copy-Item -Path $file.FullName -Destination $tempPath
        }
        catch{
            Write-Host "An error occurred:"+$error[0] + "  "+ $file.FullName  # continue if error example:he cloud file provider is not running.
        }   
    }

}
catch{
    Write-Host "An error occurred:"+$error[0]
}
  
finally{
    Write-Host "Finished."
}