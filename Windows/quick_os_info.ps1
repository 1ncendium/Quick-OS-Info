# PowerShell script that gives a quick overview of what is going on, on a particular Windows (DESKTOP) system. This is the normal mode.
# Date 11/9/2020
# Author : Remco van der Meer

#Variables
$OSInfo = Get-ComputerInfo -Property "os*"
$TimeZone = Get-TimeZone
$Processes = Get-Process | Get-Unique | Format-List -Property ProcessName,FileVersion,StartTime,ID ## Filters all processes by unique process names.
$List_users = Get-LocalUser -Name * | select * ## Lists all the information about an account.
$NetworkInfo = ipconfig

#Main
function DisplayInfo() {

    $Title = "Quick OS Info version 1.0 by Remco van der Meer"
    Write-Host "`n================ $Title ================"
    
    #OS Info
    Write-Host "`n======== System Info ========"
    $OSInfo

    #TimeZone
    Write-Host "`n======== TimeZone ========"
    $TimeZone

    #Processes
    Write-Host "`n======== Processes ========"
    $Processes

    #List users
    Write-Host "`n======== Users on machine ========"

    #Network Info
    Write-Host "`n======== Network Info ========"
    $NetworkInfo
}

#Call function
DisplayInfo