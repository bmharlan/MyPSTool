<#.Synopsis 
Get drives bases on percentage free space
.DESCRIPTION
This command will get all local drives that have less than the specified
percentage of free space available
.PARAMETER MinimumPercentFree
The minimum percent free disk space. The default value is 10 but you may enter a value between 1 and 100
.PARAMETER ComputerName
This specifies the computer name to gather information from. The default value is local host but you may specify your own computer name
#>
Param (
    $ComputerName = 'localhost',
    $MinimumPercentFree = 50
)
#convert minimum percent free
$minpercent = $MinimumPercentFree / 100
Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName $ComputerName `
    -Filter 'drivetype=3' |
Where-Object { $_.FreeSpace / $_.Size -lt $minpercent } |
Select-Object -Property DeviceID, FreeSpace, Size