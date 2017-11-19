Function Connect_VCS {
Write-Output "Please enter the VCS to connect to"
$vcs = Read-Host
Write-Output "Please enter user name"
$user_name = Read-Host
Write-Output "Please enter password"
$pw = Read-Host
try{
Connect-VIServer -Server $vcs -User $user_name -Password $pw 
}
catch{
echo $Error[0] #This will display the first error it catches i.e. bad server name, User || P/W invalid
}
}

<#Get_Host_Names not yet used #>

Function Get_Host_Names {
$hosts = New-Object System.Collections.ArrayList
while($host_name = Read-Host "Please enter hosts to pull configs for. Enter nothing when done"){
if($host_name -eq "" -or $host_name -eq $null){
return $hosts
}
$hosts+=$host_name
}
return $hosts
}


Function Get_Configs{
Connect_VCS
New-Item -ItemType Directory -Force -Path C:\Users\$env:USERNAME\host_backups #This creates a host_backups folder if it doesn't exist
get-vmhost | get-vmhostfirmware -BackupConfiguration -DestinationPath C:\Users\$env:USERNAME\host_backups
}
<# Ping_Hosts probably useless but good test for array operations#>
Function Ping_Hosts{
$host_list = Get_Host_Names
foreach($hst in $host_list){
Test-Connection $hst -Verbose
}
}

Get_Configs



