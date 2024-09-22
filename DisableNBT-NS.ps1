Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy Bypass

#disable netbios
Write-Output "disabling netbios..."
(Get-WmiObject Win32_NetworkAdapterConfiguration -Filter IpEnabled="true").SetTcpipNetbios(2) | Out-Null

#disable lmhost lookup
Write-Output "disabling lmhost lookup..."
$nicClass = Get-WmiObject -list Win32_NetworkAdapterConfiguration 
$nicClass.enablewins($false,$false) | Out-Null

Write-Output "displaying results..."
#show status, should be 2 and false
Get-WmiObject Win32_NetworkAdapterConfiguration -Filter IpEnabled="true" | FT Description, TcpipNetbiosOptions, WINSEnableLMHostsLookup

Start-Sleep -Seconds 30