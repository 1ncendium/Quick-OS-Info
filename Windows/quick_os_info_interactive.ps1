# PowerShell script that gives a quick overview of what is going on, on a particular Windows (DESKTOP) system. This is the interactive mode.
# Date 11/9/2020
# Author : Remco van der Meer

#Variables
$OSInfo = Get-ComputerInfo -Property "os*"
$TimeZone = Get-TimeZone
$Processes = Get-Process | Get-Unique | Format-List -Property ProcessName,FileVersion,StartTime,ID ## Filters all processes by unique process names.
$List_users = Get-LocalUser -Name * | select * ## Lists all the information about an account.
$NetworkInfo = ipconfig

# Menu
function Menu() {

    $Title = "Quick OS Info (Interactive mode) version 1.0 by Remco van der Meer"

    Write-Host "
    
    ================ $Title ================

    Options:
        1. Get OS Info
        2. Get TimeZone
        3. Get Processes
        4. Get user accounts
        5. Get Network settings
        6. Get all of the above
    "
    # Get user option

    function GetOption() {
    $Input = Read-Host -Prompt "Select option"
    
        function showAll() {
            $OSInfo
            $TimeZone
            $Processes
            $List_users_short
            $List_users_long
            $NetworkInfo
        }

        # Actions
        if ($Input -eq 1) {
          $OSInfo
          GetOption
        } elseif ($Input -eq 2) {
          $TimeZone
          GetOption
        } elseif ($Input -eq 3) {
          $Processes
          GetOption
        } elseif ($Input -eq 4) {
          $List_users
          GetOption
        } elseif ($Input -eq 5) {
          $NetworkInfo
          GetOption
        } elseif ($Input -eq 6) {
          showAll
          Write-Host "===== End of script ====="
          GetOption
        } else {
          Write-Host "Error please try again..."
          GetOption
        }
    }
      GetOption # Asks for the option when the script is started
}

# Call function "Menu"
Menu